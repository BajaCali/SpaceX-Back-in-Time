// swiftlint:disable all
import Foundation

#if DEBUG
extension LaunchesRaw {
    static var firstPage: Data {
        """
        {"docs":[{"fairings":{"reused":false,"recovery_attempt":false,"recovered":false,"ships":[]},"links":{"patch":{"small":"https://images2.imgbox.com/94/f2/NN6Ph45r_o.png","large":"https://images2.imgbox.com/5b/02/QcxHUb5V_o.png"},"reddit":{"campaign":null,"launch":null,"media":null,"recovery":null},"flickr":{"small":[],"original":[]},"presskit":null,"webcast":"https://www.youtube.com/watch?v=0a_00nJ_Y88","youtube_id":"0a_00nJ_Y88","article":"https://www.space.com/2196-spacex-inaugural-falcon-1-rocket-lost-launch.html","wikipedia":"https://en.wikipedia.org/wiki/DemoSat"},"static_fire_date_utc":"2006-03-17T00:00:00.000Z","static_fire_date_unix":1142553600,"net":false,"window":0,"rocket":"5e9d0d95eda69955f709d1eb","success":false,"failures":[{"time":33,"altitude":null,"reason":"merlin engine failure"}],"details":"Engine failure at 33 seconds and loss of vehicle","crew":[],"ships":[],"capsules":[],"payloads":["5eb0e4b5b6c3bb0006eeb1e1"],"launchpad":"5e9e4502f5090995de566f86","flight_number":1,"name":"FalconSat","date_utc":"2006-03-24T22:30:00.000Z","date_unix":1143239400,"date_local":"2006-03-25T10:30:00+12:00","date_precision":"hour","upcoming":false,"cores":[{"core":"5e9e289df35918033d3b2623","flight":1,"gridfins":false,"legs":false,"reused":false,"landing_attempt":false,"landing_success":null,"landing_type":null,"landpad":null}],"auto_update":true,"tbd":false,"launch_library_id":null,"id":"5eb87cd9ffd86e000604b32a"},{"fairings":{"reused":false,"recovery_attempt":false,"recovered":false,"ships":[]},"links":{"patch":{"small":"https://images2.imgbox.com/f9/4a/ZboXReNb_o.png","large":"https://images2.imgbox.com/80/a2/bkWotCIS_o.png"},"reddit":{"campaign":null,"launch":null,"media":null,"recovery":null},"flickr":{"small":[],"original":[]},"presskit":null,"webcast":"https://www.youtube.com/watch?v=Lk4zQ2wP-Nc","youtube_id":"Lk4zQ2wP-Nc","article":"https://www.space.com/3590-spacex-falcon-1-rocket-fails-reach-orbit.html","wikipedia":"https://en.wikipedia.org/wiki/DemoSat"},"static_fire_date_utc":null,"static_fire_date_unix":null,"net":false,"window":0,"rocket":"5e9d0d95eda69955f709d1eb","success":false,"failures":[{"time":301,"altitude":289,"reason":"harmonic oscillation leading to premature engine shutdown"}],"details":"Successful first stage burn and transition to second stage, maximum altitude 289 km, Premature engine shutdown at T+7 min 30 s, Failed to reach orbit, Failed to recover first stage","crew":[],"ships":[],"capsules":[],"payloads":["5eb0e4b6b6c3bb0006eeb1e2"],"launchpad":"5e9e4502f5090995de566f86","flight_number":2,"name":"DemoSat","date_utc":"2007-03-21T01:10:00.000Z","date_unix":1174439400,"date_local":"2007-03-21T13:10:00+12:00","date_precision":"hour","upcoming":false,"cores":[{"core":"5e9e289ef35918416a3b2624","flight":1,"gridfins":false,"legs":false,"reused":false,"landing_attempt":false,"landing_success":null,"landing_type":null,"landpad":null}],"auto_update":true,"tbd":false,"launch_library_id":null,"id":"5eb87cdaffd86e000604b32b"},{"fairings":{"reused":false,"recovery_attempt":false,"recovered":false,"ships":[]},"links":{"patch":{"small":"https://images2.imgbox.com/6c/cb/na1tzhHs_o.png","large":"https://images2.imgbox.com/4a/80/k1oAkY0k_o.png"},"reddit":{"campaign":null,"launch":null,"media":null,"recovery":null},"flickr":{"small":[],"original":[]},"presskit":null,"webcast":"https://www.youtube.com/watch?v=v0w9p3U8860","youtube_id":"v0w9p3U8860","article":"http://www.spacex.com/news/2013/02/11/falcon-1-flight-3-mission-summary","wikipedia":"https://en.wikipedia.org/wiki/Trailblazer_(satellite)"},"static_fire_date_utc":null,"static_fire_date_unix":null,"net":false,"window":0,"rocket":"5e9d0d95eda69955f709d1eb","success":false,"failures":[{"time":140,"altitude":35,"reason":"residual stage-1 thrust led to collision between stage 1 and stage 2"}],"details":"Residual stage 1 thrust led to collision between stage 1 and stage 2","crew":[],"ships":[],"capsules":[],"payloads":["5eb0e4b6b6c3bb0006eeb1e3","5eb0e4b6b6c3bb0006eeb1e4"],"launchpad":"5e9e4502f5090995de566f86","flight_number":3,"name":"Trailblazer","date_utc":"2008-08-03T03:34:00.000Z","date_unix":1217734440,"date_local":"2008-08-03T15:34:00+12:00","date_precision":"hour","upcoming":false,"cores":[{"core":"5e9e289ef3591814873b2625","flight":1,"gridfins":false,"legs":false,"reused":false,"landing_attempt":false,"landing_success":null,"landing_type":null,"landpad":null}],"auto_update":true,"tbd":false,"launch_library_id":null,"id":"5eb87cdbffd86e000604b32c"},{"fairings":{"reused":false,"recovery_attempt":false,"recovered":false,"ships":[]},"links":{"patch":{"small":"https://images2.imgbox.com/95/39/sRqN7rsv_o.png","large":"https://images2.imgbox.com/a3/99/qswRYzE8_o.png"},"reddit":{"campaign":null,"launch":null,"media":null,"recovery":null},"flickr":{"small":[],"original":[]},"presskit":null,"webcast":"https://www.youtube.com/watch?v=dLQ2tZEH6G0","youtube_id":"dLQ2tZEH6G0","article":"https://en.wikipedia.org/wiki/Ratsat","wikipedia":"https://en.wikipedia.org/wiki/Ratsat"},"static_fire_date_utc":"2008-09-20T00:00:00.000Z","static_fire_date_unix":1221868800,"net":false,"window":0,"rocket":"5e9d0d95eda69955f709d1eb","success":true,"failures":[],"details":"Ratsat was carried to orbit on the first successful orbital launch of any privately funded and developed, liquid-propelled carrier rocket, the SpaceX Falcon 1","crew":[],"ships":[],"capsules":[],"payloads":["5eb0e4b7b6c3bb0006eeb1e5"],"launchpad":"5e9e4502f5090995de566f86","flight_number":4,"name":"RatSat","date_utc":"2008-09-28T23:15:00.000Z","date_unix":1222643700,"date_local":"2008-09-28T11:15:00+12:00","date_precision":"hour","upcoming":false,"cores":[{"core":"5e9e289ef3591855dc3b2626","flight":1,"gridfins":false,"legs":false,"reused":false,"landing_attempt":false,"landing_success":null,"landing_type":null,"landpad":null}],"auto_update":true,"tbd":false,"launch_library_id":null,"id":"5eb87cdbffd86e000604b32d"},{"fairings":{"reused":false,"recovery_attempt":false,"recovered":false,"ships":[]},"links":{"patch":{"small":"https://images2.imgbox.com/ab/5a/Pequxd5d_o.png","large":"https://images2.imgbox.com/92/e4/7Cf6MLY0_o.png"},"reddit":{"campaign":null,"launch":null,"media":null,"recovery":null},"flickr":{"small":[],"original":[]},"presskit":"http://www.spacex.com/press/2012/12/19/spacexs-falcon-1-successfully-delivers-razaksat-satellite-orbit","webcast":"https://www.youtube.com/watch?v=yTaIDooc8Og","youtube_id":"yTaIDooc8Og","article":"http://www.spacex.com/news/2013/02/12/falcon-1-flight-5","wikipedia":"https://en.wikipedia.org/wiki/RazakSAT"},"static_fire_date_utc":null,"static_fire_date_unix":null,"net":false,"window":0,"rocket":"5e9d0d95eda69955f709d1eb","success":true,"failures":[],"details":null,"crew":[],"ships":[],"capsules":[],"payloads":["5eb0e4b7b6c3bb0006eeb1e6"],"launchpad":"5e9e4502f5090995de566f86","flight_number":5,"name":"RazakSat","date_utc":"2009-07-13T03:35:00.000Z","date_unix":1247456100,"date_local":"2009-07-13T15:35:00+12:00","date_precision":"hour","upcoming":false,"cores":[{"core":"5e9e289ef359184f103b2627","flight":1,"gridfins":false,"legs":false,"reused":false,"landing_attempt":false,"landing_success":null,"landing_type":null,"landpad":null}],"auto_update":true,"tbd":false,"launch_library_id":null,"id":"5eb87cdcffd86e000604b32e"},{"fairings":{"reused":null,"recovery_attempt":null,"recovered":null,"ships":[]},"links":{"patch":{"small":"https://images2.imgbox.com/73/7f/u7BKqv2C_o.png","large":"https://images2.imgbox.com/66/b4/8KZsjbt4_o.png"},"reddit":{"campaign":null,"launch":null,"media":null,"recovery":null},"flickr":{"small":[],"original":[]},"presskit":"http://forum.nasaspaceflight.com/index.php?action=dlattach;topic=21869.0;attach=230821","webcast":"https://www.youtube.com/watch?v=nxSxgBKlYws","youtube_id":"nxSxgBKlYws","article":"http://www.spacex.com/news/2013/02/12/falcon-9-flight-1","wikipedia":"https://en.wikipedia.org/wiki/Dragon_Spacecraft_Qualification_Unit"},"static_fire_date_utc":"2010-03-13T00:00:00.000Z","static_fire_date_unix":1268438400,"net":false,"window":0,"rocket":"5e9d0d95eda69973a809d1ec","success":true,"failures":[],"details":null,"crew":[],"ships":[],"capsules":[],"payloads":["5eb0e4b7b6c3bb0006eeb1e7"],"launchpad":"5e9e4501f509094ba4566f84","flight_number":6,"name":"Falcon 9 Test Flight","date_utc":"2010-06-04T18:45:00.000Z","date_unix":1275677100,"date_local":"2010-06-04T14:45:00-04:00","date_precision":"hour","upcoming":false,"cores":[{"core":"5e9e289ef359185f2b3b2628","flight":1,"gridfins":false,"legs":false,"reused":false,"landing_attempt":false,"landing_success":null,"landing_type":null,"landpad":null}],"auto_update":true,"tbd":false,"launch_library_id":null,"id":"5eb87cddffd86e000604b32f"},{"fairings":null,"links":{"patch":{"small":"https://images2.imgbox.com/fa/dc/FOUDQ0Sn_o.png","large":"https://images2.imgbox.com/04/6e/kniggvWD_o.png"},"reddit":{"campaign":null,"launch":null,"media":null,"recovery":null},"flickr":{"small":[],"original":[]},"presskit":"http://www.spacex.com/files/downloads/cots1-20101206.pdf","webcast":"https://www.youtube.com/watch?v=cdLITgWKe_0","youtube_id":"cdLITgWKe_0","article":"https://en.wikipedia.org/wiki/SpaceX_COTS_Demo_Flight_1","wikipedia":"https://en.wikipedia.org/wiki/SpaceX_COTS_Demo_Flight_1"},"static_fire_date_utc":"2010-12-04T00:00:00.000Z","static_fire_date_unix":1291420800,"net":false,"window":0,"rocket":"5e9d0d95eda69973a809d1ec","success":true,"failures":[],"details":null,"crew":[],"ships":["5ea6ed2d080df4000697c901"],"capsules":["5e9e2c5bf35918ed873b2664"],"payloads":["5eb0e4b9b6c3bb0006eeb1e8","5eb0e4b9b6c3bb0006eeb1e9"],"launchpad":"5e9e4501f509094ba4566f84","flight_number":7,"name":"COTS 1","date_utc":"2010-12-08T15:43:00.000Z","date_unix":1291822980,"date_local":"2010-12-08T11:43:00-04:00","date_precision":"hour","upcoming":false,"cores":[{"core":"5e9e289ef35918187c3b2629","flight":1,"gridfins":false,"legs":false,"reused":false,"landing_attempt":false,"landing_success":null,"landing_type":null,"landpad":null}],"auto_update":true,"tbd":false,"launch_library_id":null,"id":"5eb87cdeffd86e000604b330"},{"fairings":null,"links":{"patch":{"small":"https://images2.imgbox.com/c5/f4/XfLVgbaO_o.png","large":"https://images2.imgbox.com/94/8d/YnZ1SLsT_o.png"},"reddit":{"campaign":null,"launch":null,"media":null,"recovery":null},"flickr":{"small":[],"original":[]},"presskit":"https://www.nasa.gov/pdf/649910main_cots2_presskit_051412.pdf","webcast":"https://www.youtube.com/watch?v=tpQzDbAY7yI","youtube_id":"tpQzDbAY7yI","article":"https://en.wikipedia.org/wiki/Dragon_C2%2B","wikipedia":"https://en.wikipedia.org/wiki/Dragon_C2%2B"},"static_fire_date_utc":"2012-04-30T00:00:00.000Z","static_fire_date_unix":1335744000,"net":false,"window":0,"rocket":"5e9d0d95eda69973a809d1ec","success":true,"failures":[],"details":"Launch was scrubbed on first attempt, second launch attempt was successful","crew":[],"ships":["5ea6ed2d080df4000697c901"],"capsules":["5e9e2c5bf3591882af3b2665"],"payloads":["5eb0e4bab6c3bb0006eeb1ea"],"launchpad":"5e9e4501f509094ba4566f84","flight_number":8,"name":"COTS 2","date_utc":"2012-05-22T07:44:00.000Z","date_unix":1335944640,"date_local":"2012-05-22T03:44:00-04:00","date_precision":"hour","upcoming":false,"cores":[{"core":"5e9e289ef35918f39c3b262a","flight":1,"gridfins":false,"legs":false,"reused":false,"landing_attempt":false,"landing_success":null,"landing_type":null,"landpad":null}],"auto_update":true,"tbd":false,"launch_library_id":null,"id":"5eb87cdfffd86e000604b331"},{"fairings":null,"links":{"patch":{"small":"https://images2.imgbox.com/3e/91/hlGiK49a_o.png","large":"https://images2.imgbox.com/fb/42/0V9JgYQS_o.png"},"reddit":{"campaign":null,"launch":null,"media":null,"recovery":null},"flickr":{"small":[],"original":[]},"presskit":"https://www.nasa.gov/pdf/694166main_SpaceXCRS-1PressKit.pdf","webcast":"https://www.youtube.com/watch?v=-Vk3hiV_zXU","youtube_id":"-Vk3hiV_zXU","article":"https://www.nasa.gov/mission_pages/station/main/spacex-crs1-target.html","wikipedia":"https://en.wikipedia.org/wiki/SpaceX_CRS-1"},"static_fire_date_utc":"2012-09-29T00:00:00.000Z","static_fire_date_unix":1348876800,"net":false,"window":0,"rocket":"5e9d0d95eda69973a809d1ec","success":true,"failures":[],"details":"CRS-1 successful, but the secondary payload was inserted into abnormally low orbit and lost due to Falcon 9 boost stage engine failure, ISS visiting vehicle safety rules, and the primary payload owner's contractual right to decline a second ignition of the second stage under some conditions.","crew":[],"ships":["5ea6ed2d080df4000697c902"],"capsules":["5e9e2c5bf3591835983b2666"],"payloads":["5eb0e4bab6c3bb0006eeb1eb","5eb0e4bab6c3bb0006eeb1ec"],"launchpad":"5e9e4501f509094ba4566f84","flight_number":9,"name":"CRS-1","date_utc":"2012-10-08T00:35:00.000Z","date_unix":1349656500,"date_local":"2012-10-08T20:35:00-04:00","date_precision":"hour","upcoming":false,"cores":[{"core":"5e9e289ff3591821a73b262b","flight":1,"gridfins":false,"legs":false,"reused":false,"landing_attempt":false,"landing_success":null,"landing_type":null,"landpad":null}],"auto_update":true,"tbd":false,"launch_library_id":null,"id":"5eb87ce0ffd86e000604b332"},{"fairings":null,"links":{"patch":{"small":"https://images2.imgbox.com/bd/fe/lXUYKL28_o.png","large":"https://images2.imgbox.com/bc/c5/fHN3m8KV_o.png"},"reddit":{"campaign":null,"launch":"https://www.reddit.com/r/space/comments/19gm5f/live_coverage_spacex_crs2_launch_to_the_iss/c8nvah4","media":null,"recovery":null},"flickr":{"small":[],"original":[]},"presskit":"https://www.nasa.gov/sites/default/files/files/Orb2_PRESS_KIT.pdf","webcast":"https://www.youtube.com/watch?v=ik0ElKl5kW4","youtube_id":"ik0ElKl5kW4","article":"https://en.wikipedia.org/wiki/SpaceX_CRS-2","wikipedia":"https://en.wikipedia.org/wiki/SpaceX_CRS-2"},"static_fire_date_utc":"2013-02-25T18:30:00.000Z","static_fire_date_unix":1361817000,"net":false,"window":0,"rocket":"5e9d0d95eda69973a809d1ec","success":true,"failures":[],"details":"Last launch of the original Falcon 9 v1.0 launch vehicle","crew":[],"ships":["5ea6ed2d080df4000697c902"],"capsules":["5e9e2c5bf359189ef23b2667"],"payloads":["5eb0e4bbb6c3bb0006eeb1ed"],"launchpad":"5e9e4501f509094ba4566f84","flight_number":10,"name":"CRS-2","date_utc":"2013-03-01T19:10:00.000Z","date_unix":1362165000,"date_local":"2013-03-01T15:10:00-04:00","date_precision":"hour","upcoming":false,"cores":[{"core":"5e9e289ff3591884e03b262c","flight":1,"gridfins":false,"legs":false,"reused":false,"landing_attempt":false,"landing_success":null,"landing_type":null,"landpad":null}],"auto_update":true,"tbd":false,"launch_library_id":null,"id":"5eb87ce1ffd86e000604b333"}],"totalDocs":205,"offset":0,"limit":10,"totalPages":21,"page":1,"pagingCounter":1,"hasPrevPage":false,"hasNextPage":true,"prevPage":null,"nextPage":2}
""".data(using: .utf8)!
    }

    static var lastPage: Data {
        """
{
    "docs": [
        {
            "fairings": {
                "reused": null,
                "recovery_attempt": null,
                "recovered": null,
                "ships": []
            },
            "links": {
                "patch": {
                    "small": null,
                    "large": null
                },
                "reddit": {
                    "campaign": null,
                    "launch": null,
                    "media": null,
                    "recovery": null
                },
                "flickr": {
                    "small": [],
                    "original": []
                },
                "presskit": null,
                "webcast": null,
                "youtube_id": null,
                "article": null,
                "wikipedia": null
            },
            "static_fire_date_utc": null,
            "static_fire_date_unix": null,
            "net": false,
            "window": null,
            "rocket": "5e9d0d95eda69973a809d1ec",
            "success": null,
            "failures": [],
            "details": null,
            "crew": [],
            "ships": [],
            "capsules": [],
            "payloads": [],
            "launchpad": "5e9e4501f509094ba4566f84",
            "flight_number": 193,
            "name": "ispace Mission 1 & Rashid",
            "date_utc": "2022-11-22T00:00:00.000Z",
            "date_unix": 1669075200,
            "date_local": "2022-11-21T19:00:00-05:00",
            "date_precision": "day",
            "upcoming": true,
            "cores": [
                {
                    "core": null,
                    "flight": null,
                    "gridfins": true,
                    "legs": true,
                    "reused": false,
                    "landing_attempt": null,
                    "landing_success": null,
                    "landing_type": null,
                    "landpad": null
                }
            ],
            "auto_update": true,
            "tbd": false,
            "launch_library_id": null,
            "id": "633f723d0531f07b4fdf59c4"
        },
        {
            "fairings": {
                "reused": null,
                "recovery_attempt": null,
                "recovered": null,
                "ships": []
            },
            "links": {
                "patch": {
                    "small": null,
                    "large": null
                },
                "reddit": {
                    "campaign": null,
                    "launch": null,
                    "media": null,
                    "recovery": null
                },
                "flickr": {
                    "small": [],
                    "original": []
                },
                "presskit": null,
                "webcast": null,
                "youtube_id": null,
                "article": null,
                "wikipedia": null
            },
            "static_fire_date_utc": null,
            "static_fire_date_unix": null,
            "net": false,
            "window": null,
            "rocket": "5e9d0d95eda69973a809d1ec",
            "success": null,
            "failures": [],
            "details": null,
            "crew": [],
            "ships": [],
            "capsules": [],
            "payloads": [],
            "launchpad": "5e9e4501f509094ba4566f84",
            "flight_number": 192,
            "name": "Eutelsat 10B",
            "date_utc": "2022-11-15T00:00:00.000Z",
            "date_unix": 1668470400,
            "date_local": "2022-11-14T19:00:00-05:00",
            "date_precision": "day",
            "upcoming": true,
            "cores": [
                {
                    "core": null,
                    "flight": null,
                    "gridfins": true,
                    "legs": true,
                    "reused": false,
                    "landing_attempt": null,
                    "landing_success": null,
                    "landing_type": null,
                    "landpad": null
                }
            ],
            "auto_update": true,
            "tbd": false,
            "launch_library_id": null,
            "id": "633f71b60531f07b4fdf59bf"
        },
        {
            "fairings": {
                "reused": null,
                "recovery_attempt": null,
                "recovered": null,
                "ships": []
            },
            "links": {
                "patch": {
                    "small": null,
                    "large": null
                },
                "reddit": {
                    "campaign": null,
                    "launch": null,
                    "media": null,
                    "recovery": null
                },
                "flickr": {
                    "small": [],
                    "original": []
                },
                "presskit": null,
                "webcast": null,
                "youtube_id": null,
                "article": null,
                "wikipedia": null
            },
            "static_fire_date_utc": null,
            "static_fire_date_unix": null,
            "net": false,
            "window": null,
            "rocket": "5e9d0d95eda69973a809d1ec",
            "success": null,
            "failures": [],
            "details": null,
            "crew": [],
            "ships": [],
            "capsules": [],
            "payloads": [],
            "launchpad": "5e9e4501f509094ba4566f84",
            "flight_number": 191,
            "name": "Galaxy 31 (23R) & 32 (17R)",
            "date_utc": "2022-11-08T00:00:00.000Z",
            "date_unix": 1667865600,
            "date_local": "2022-11-07T19:00:00-05:00",
            "date_precision": "day",
            "upcoming": true,
            "cores": [
                {
                    "core": null,
                    "flight": null,
                    "gridfins": true,
                    "legs": true,
                    "reused": false,
                    "landing_attempt": null,
                    "landing_success": null,
                    "landing_type": null,
                    "landpad": null
                }
            ],
            "auto_update": true,
            "tbd": false,
            "launch_library_id": null,
            "id": "633f71a90531f07b4fdf59be"
        },
        {
            "fairings": {
                "reused": null,
                "recovery_attempt": null,
                "recovered": null,
                "ships": []
            },
            "links": {
                "patch": {
                    "small": null,
                    "large": null
                },
                "reddit": {
                    "campaign": null,
                    "launch": null,
                    "media": null,
                    "recovery": null
                },
                "flickr": {
                    "small": [],
                    "original": []
                },
                "presskit": null,
                "webcast": null,
                "youtube_id": null,
                "article": null,
                "wikipedia": null
            },
            "static_fire_date_utc": null,
            "static_fire_date_unix": null,
            "net": false,
            "window": null,
            "rocket": "5e9d0d95eda69973a809d1ec",
            "success": null,
            "failures": [],
            "details": null,
            "crew": [],
            "ships": [],
            "capsules": [],
            "payloads": [],
            "launchpad": "5e9e4501f509094ba4566f84",
            "flight_number": 189,
            "name": "Hotbird 13G",
            "date_utc": "2022-11-03T03:24:00.000Z",
            "date_unix": 1667445840,
            "date_local": "2022-11-02T23:24:00-04:00",
            "date_precision": "hour",
            "upcoming": true,
            "cores": [
                {
                    "core": null,
                    "flight": null,
                    "gridfins": true,
                    "legs": true,
                    "reused": false,
                    "landing_attempt": null,
                    "landing_success": null,
                    "landing_type": null,
                    "landpad": null
                }
            ],
            "auto_update": true,
            "tbd": false,
            "launch_library_id": null,
            "id": "633f71dd0531f07b4fdf59c1"
        },
        {
            "fairings": {
                "reused": null,
                "recovery_attempt": null,
                "recovered": null,
                "ships": []
            },
            "links": {
                "patch": {
                    "small": null,
                    "large": null
                },
                "reddit": {
                    "campaign": null,
                    "launch": null,
                    "media": null,
                    "recovery": null
                },
                "flickr": {
                    "small": [],
                    "original": []
                },
                "presskit": null,
                "webcast": null,
                "youtube_id": null,
                "article": null,
                "wikipedia": null
            },
            "static_fire_date_utc": null,
            "static_fire_date_unix": null,
            "net": false,
            "window": null,
            "rocket": "5e9d0d95eda69973a809d1ec",
            "success": null,
            "failures": [],
            "details": null,
            "crew": [],
            "ships": [],
            "capsules": [],
            "payloads": [],
            "launchpad": "5e9e4501f509094ba4566f84",
            "flight_number": 188,
            "name": "Hotbird 13F",
            "date_utc": "2022-10-15T05:22:00.000Z",
            "date_unix": 1665811320,
            "date_local": "2022-10-15T01:22:00-04:00",
            "date_precision": "hour",
            "upcoming": true,
            "cores": [
                {
                    "core": null,
                    "flight": null,
                    "gridfins": true,
                    "legs": true,
                    "reused": false,
                    "landing_attempt": null,
                    "landing_success": null,
                    "landing_type": null,
                    "landpad": null
                }
            ],
            "auto_update": true,
            "tbd": false,
            "launch_library_id": null,
            "id": "633f71370531f07b4fdf59bc"
        },
        {
            "fairings": {
                "reused": null,
                "recovery_attempt": null,
                "recovered": null,
                "ships": []
            },
            "links": {
                "patch": {
                    "small": null,
                    "large": null
                },
                "reddit": {
                    "campaign": null,
                    "launch": null,
                    "media": null,
                    "recovery": null
                },
                "flickr": {
                    "small": [],
                    "original": []
                },
                "presskit": null,
                "webcast": null,
                "youtube_id": null,
                "article": null,
                "wikipedia": null
            },
            "static_fire_date_utc": null,
            "static_fire_date_unix": null,
            "net": false,
            "window": null,
            "rocket": "5e9d0d95eda69973a809d1ec",
            "success": null,
            "failures": [],
            "details": null,
            "crew": [],
            "ships": [],
            "capsules": [],
            "payloads": [],
            "launchpad": "5e9e4501f509094ba4566f84",
            "flight_number": 188,
            "name": "Galaxy 33 (15R) & 34 (12R)",
            "date_utc": "2022-10-08T23:05:00.000Z",
            "date_unix": 1665270300,
            "date_local": "2022-10-08T19:05:00-04:00",
            "date_precision": "hour",
            "upcoming": true,
            "cores": [
                {
                    "core": null,
                    "flight": null,
                    "gridfins": true,
                    "legs": true,
                    "reused": false,
                    "landing_attempt": null,
                    "landing_success": null,
                    "landing_type": null,
                    "landpad": null
                }
            ],
            "auto_update": true,
            "tbd": false,
            "launch_library_id": "13977bd5-45d2-4ed1-9a4a-9fefeee0723a",
            "id": "633f71240531f07b4fdf59bb"
        },
        {
            "fairings": {
                "reused": null,
                "recovery_attempt": null,
                "recovered": null,
                "ships": []
            },
            "links": {
                "patch": {
                    "small": "https://images2.imgbox.com/a9/9a/NXVkTZCE_o.png",
                    "large": "https://images2.imgbox.com/e3/cc/hN96PmST_o.png"
                },
                "reddit": {
                    "campaign": "https://www.reddit.com/r/spacex/comments/jhu37i/starlink_general_discussion_and_deployment_thread/",
                    "launch": null,
                    "media": null,
                    "recovery": "https://www.reddit.com/r/spacex/comments/k2ts1q/rspacex_fleet_updates_discussion_thread/"
                },
                "flickr": {
                    "small": [],
                    "original": []
                },
                "presskit": null,
                "webcast": "https://youtu.be/iYtH2khNIgU",
                "youtube_id": "iYtH2khNIgU",
                "article": null,
                "wikipedia": null
            },
            "static_fire_date_utc": null,
            "static_fire_date_unix": null,
            "net": false,
            "window": null,
            "rocket": "5e9d0d95eda69973a809d1ec",
            "success": null,
            "failures": [],
            "details": null,
            "crew": [],
            "ships": [],
            "capsules": [],
            "payloads": [
                "631616aeffc78f3b8567071b"
            ],
            "launchpad": "5e9e4501f509094ba4566f84",
            "flight_number": 188,
            "name": "Starlink 4-36 (v1.5)",
            "date_utc": "2022-10-20T14:50:00.000Z",
            "date_unix": 1666277400,
            "date_local": "2022-10-20T10:50:00-04:00",
            "date_precision": "hour",
            "upcoming": true,
            "cores": [
                {
                    "core": null,
                    "flight": null,
                    "gridfins": null,
                    "legs": null,
                    "reused": null,
                    "landing_attempt": null,
                    "landing_success": null,
                    "landing_type": null,
                    "landpad": null
                }
            ],
            "auto_update": true,
            "tbd": false,
            "launch_library_id": "aa88b853-9e04-4a28-9433-d87799331b1b",
            "id": "63161345ffc78f3b8567070d"
        },
        {
            "fairings": {
                "reused": null,
                "recovery_attempt": null,
                "recovered": null,
                "ships": []
            },
            "links": {
                "patch": {
                    "small": null,
                    "large": null
                },
                "reddit": {
                    "campaign": null,
                    "launch": null,
                    "media": null,
                    "recovery": null
                },
                "flickr": {
                    "small": [],
                    "original": []
                },
                "presskit": null,
                "webcast": "https://youtu.be/pY628jRd6gM",
                "youtube_id": "pY628jRd6gM",
                "article": null,
                "wikipedia": null
            },
            "static_fire_date_utc": null,
            "static_fire_date_unix": null,
            "net": false,
            "window": null,
            "rocket": "5e9d0d95eda69974db09d1ed",
            "success": null,
            "failures": [],
            "details": null,
            "crew": [],
            "ships": [],
            "capsules": [],
            "payloads": [
                "5fe3b86eb3467846b324217c"
            ],
            "launchpad": "5e9e4502f509094188566f88",
            "flight_number": 188,
            "name": "USSF-44",
            "date_utc": "2022-11-01T13:41:00.000Z",
            "date_unix": 1667310060,
            "date_local": "2022-11-01T09:41:00-04:00",
            "date_precision": "hour",
            "upcoming": true,
            "cores": [
                {
                    "core": "5fe3b8f2b3467846b3242181",
                    "flight": 1,
                    "gridfins": true,
                    "legs": true,
                    "reused": false,
                    "landing_attempt": null,
                    "landing_success": null,
                    "landing_type": null,
                    "landpad": null
                },
                {
                    "core": "5fe3b8fbb3467846b3242182",
                    "flight": 1,
                    "gridfins": true,
                    "legs": true,
                    "reused": false,
                    "landing_attempt": null,
                    "landing_success": null,
                    "landing_type": null,
                    "landpad": null
                },
                {
                    "core": "5fe3b906b3467846b3242183",
                    "flight": 1,
                    "gridfins": true,
                    "legs": true,
                    "reused": false,
                    "landing_attempt": null,
                    "landing_success": null,
                    "landing_type": null,
                    "landpad": null
                }
            ],
            "auto_update": true,
            "tbd": false,
            "launch_library_id": "2306e0bc-e1a3-4a4a-9285-e1a94073655e",
            "id": "6243aec2af52800c6e91925d"
        },
        {
            "fairings": null,
            "links": {
                "patch": {
                    "small": "https://images2.imgbox.com/eb/d8/D1Yywp0w_o.png",
                    "large": "https://images2.imgbox.com/33/2e/k6VE4iYl_o.png"
                },
                "reddit": {
                    "campaign": null,
                    "launch": "https://www.reddit.com/r/spacex/comments/xvm76j/rspacex_crew5_launchcoast_docking_discussion_and/",
                    "media": null,
                    "recovery": null
                },
                "flickr": {
                    "small": [],
                    "original": []
                },
                "presskit": null,
                "webcast": "https://youtu.be/5EwW8ZkArL4",
                "youtube_id": "5EwW8ZkArL4",
                "article": null,
                "wikipedia": "https://en.wikipedia.org/wiki/SpaceX_Crew-5"
            },
            "static_fire_date_utc": null,
            "static_fire_date_unix": null,
            "net": false,
            "window": null,
            "rocket": "5e9d0d95eda69973a809d1ec",
            "success": true,
            "failures": [],
            "details": null,
            "crew": [
                "62dd7196202306255024d13c",
                "62dd71c9202306255024d13d",
                "62dd7210202306255024d13e",
                "62dd7253202306255024d13f"
            ],
            "ships": [],
            "capsules": [
                "617c05591bad2c661a6e2909"
            ],
            "payloads": [
                "62dd73ed202306255024d145"
            ],
            "launchpad": "5e9e4502f509094188566f88",
            "flight_number": 187,
            "name": "Crew-5",
            "date_utc": "2022-10-05T16:00:00.000Z",
            "date_unix": 1664985600,
            "date_local": "2022-10-05T12:00:00-04:00",
            "date_precision": "hour",
            "upcoming": false,
            "cores": [
                {
                    "core": "633d9da635a71d1d9c66797b",
                    "flight": 1,
                    "gridfins": true,
                    "legs": true,
                    "reused": false,
                    "landing_attempt": true,
                    "landing_success": true,
                    "landing_type": "ASDS",
                    "landpad": "5e9e3033383ecbb9e534e7cc"
                }
            ],
            "auto_update": true,
            "tbd": false,
            "launch_library_id": "f33d5ece-e825-4cd8-809f-1d4c72a2e0d3",
            "id": "62dd70d5202306255024d139"
        },
        {
            "fairings": {
                "reused": null,
                "recovery_attempt": null,
                "recovered": null,
                "ships": []
            },
            "links": {
                "patch": {
                    "small": "https://images2.imgbox.com/a9/9a/NXVkTZCE_o.png",
                    "large": "https://images2.imgbox.com/e3/cc/hN96PmST_o.png"
                },
                "reddit": {
                    "campaign": "https://www.reddit.com/r/spacex/comments/jhu37i/starlink_general_discussion_and_deployment_thread/",
                    "launch": "https://www.reddit.com/r/spacex/comments/xn028t/rspacex_starlink_435_launch_discussion_and/",
                    "media": null,
                    "recovery": "https://www.reddit.com/r/spacex/comments/k2ts1q/rspacex_fleet_updates_discussion_thread/"
                },
                "flickr": {
                    "small": [],
                    "original": []
                },
                "presskit": null,
                "webcast": "https://youtu.be/VVu2bSJJhgI",
                "youtube_id": "VVu2bSJJhgI",
                "article": null,
                "wikipedia": null
            },
            "static_fire_date_utc": null,
            "static_fire_date_unix": null,
            "net": false,
            "window": null,
            "rocket": "5e9d0d95eda69973a809d1ec",
            "success": true,
            "failures": [],
            "details": null,
            "crew": [],
            "ships": [],
            "capsules": [],
            "payloads": [
                "631616a7ffc78f3b8567071a"
            ],
            "launchpad": "5e9e4501f509094ba4566f84",
            "flight_number": 186,
            "name": "Starlink 4-35 (v1.5)",
            "date_utc": "2022-09-24T23:30:00.000Z",
            "date_unix": 1664062200,
            "date_local": "2022-09-24T19:30:00-04:00",
            "date_precision": "hour",
            "upcoming": false,
            "cores": [
                {
                    "core": "627843d657b51b752c5c5a53",
                    "flight": 4,
                    "gridfins": true,
                    "legs": true,
                    "reused": true,
                    "landing_attempt": true,
                    "landing_success": true,
                    "landing_type": "ASDS",
                    "landpad": "5e9e3033383ecbb9e534e7cc"
                }
            ],
            "auto_update": true,
            "tbd": false,
            "launch_library_id": "1c903b65-6667-4fd5-944d-296c5f13e01f",
            "id": "63161339ffc78f3b8567070c"
        }
    ],
    "totalDocs": 205,
    "limit": 10,
    "totalPages": 21,
    "page": 2,
    "pagingCounter": 11,
    "hasPrevPage": true,
    "hasNextPage": true,
    "prevPage": 1,
    "nextPage": 3
}
""".data(using: .utf8)!
    }
}
#endif

// swiftlint:enable all
