PAIS Member Schools 
Academy of Notre Dame de Namur
Academy of the New Church
The Agnes Irwin School
AIM Academy
Ancillae-Assumpta Academy
Aquinas Academy
Armenian Sisters Academy
The Baldwin School
Benchmark School
Buckingham Friends School
The Campus School of Carlow University
Church Farm School
Community Day School
Community Partnership School
The Crefeld School
Delaware Valley Friends School
The Ellis School
Erie Day School
Fanny Edel Falk Laboratory School
Frankford Friends School
Friends Central School
Friends School Haverford
Friends Select School
George School
Germantown Academy
Germantown Friends School
Girard College
Gladwyne Montessori
Goshen Friends School
The Grayson School
Greene Street Friends School
Greene Towne Montessori School
Greenwood Friends School
The Grier School
Gwynedd Friends School
Gwynedd Mercy Academy High School
Harrisburg Academy
The Haverford School
The Hill School
Hill Top Preparatory School
The Hillside School
Holy Child Academy
Holy Child School at Rosemont
Holy Ghost Preparatory School
Hope Partnership for Education
Jack M. Barrack Hebrew Academy
The Janus School
Jewish Day School of the Lehigh Valley
Kentucky Avenue School
Kimberton Waldorf School
The Kiski School
Kohelet Yeshiva
La Salle College High School
Lancaster Country Day School
Lansdowne Friends School
Lancaster Friends School
Malvern Preparatory School
Meadowbrook School
Media-Providence Friends School
Mercersburg Academy
Merion Mercy Academy

Milton Hershey School
The Miquon School
MMI Preparatory School
The Montessori School
Montgomery School
Moravian Academy
Mount Saint Joseph Academy
Nazareth Prep
The Neighborhood Academy
New School Montessori
Newtown Friends School
The Pen Ryn School
Perelman Jewish Day School
Perkiomen School
The Phelps School
The Philadelphia School
The Pilot School
Pine Forge Academy
Plymouth Meeting Friends School
Project Learn School
The Quaker School at Horsham
Revolution School
River Valley Waldorf School
Sacred Heart Academy Bryn Mawr
Sanford School
The School in Rose Valley
Scranton Preparatory School
Sewickley Academy
Shady Side Academy
The Shipley School
Solebury School
Springside Chestnut Hill Academy
St. Edmund's Academy
St. James School
St. Joseph's Preparatory School
St. Peter's School
St. Stephen's Episcopal School
Stone Independent School
Stratford Friends School
Susquehanna Waldorf School
Talk School
Tower Hill School
United Friends School
Upland Country Day School
Valley School of Ligonier
Villa Joseph Marie High School
Villa Maria Academy High School
The Walden School
Waldorf School of Pittsburgh
West Chester Friends School
West Hill School
Westtown School
William Penn Charter School
Winchester Thurston School
Woodlynde School
The Wyndcroft School
Wyoming Seminary
York Country Day School
YSC Academy

#!/bin/bash

# https://knowledge.ondmarc.redsift.com/en/articles/1519838-looking-up-spf-dkim-and-dmarc-records-in-dns

# Output file
output_file="dns_results.txt"

# List of domains to query
domains=("bfs.org" "rivervalleyschool.org" "princetonfriendsschool.org")

# Clear the output file
echo -e "Domain\tSPF\tDKIM\tDMARC" > "$output_file"

for DOMAIN in "${domains[@]}"
do
    # SPF Record
    SPF=$(dig txt $DOMAIN +short | grep -q spf && echo "true" || echo "false")

    # DKIM Record for Google
    DKIM=$(dig txt google._domainkey.$DOMAIN +short | grep -q google && echo "true" || echo "false")

    # DMARC Record
    DMARC=$(dig txt _dmarc.$DOMAIN +short | grep -q dmarc && echo "true" || echo "false")

    # Display in terminal
    echo -e "Domain: $DOMAIN\tSPF: $SPF\tDKIM: $DKIM\tDMARC: $DMARC"

    # Append to output file
    echo -e "$DOMAIN\t$SPF\t$DKIM\t$DMARC" >> "$output_file"

    echo "------------------------"
done

echo "Results are saved in $output_file"



