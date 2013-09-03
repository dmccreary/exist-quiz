xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../modules/style.xqm';

let $title := 'List Quizes'

let $app-collection := $style:app-home
let $data-collection := concat($app-collection, '/data')

let $content :=
<div class="content">
List of quizes in: {$data-collection}
       <table>
           <thead>
           <tr>
              <th>File Name</th>
              <th>Description</th>
              <th># Questions</th>
              <th>View XML</th>
              <th>View HTML</th>
           </tr>
        </thead>
        <tbody>{
          for $quiz at $count in collection($data-collection)/quiz
             let $file-name := util:document-name($quiz)
             let $last-modified := xmldb:last-modified($data-collection, $file-name)
             order by $last-modified
          return
             <tr>
                 {if ($count mod 2)
                     then attribute class {'odd'}
                     else attribute class {'even'}
                 }
                 <th>{$file-name}</th>
                 <td>{$quiz/description/text()}</td>
                 <td><a href="view-item.xq?file-name={$file-name}">View</a></td>
             </tr> 
       }</tbody>
       </table>
  
</div>

return style:assemble-page($title, $content)