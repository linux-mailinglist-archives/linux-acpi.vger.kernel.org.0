Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79DB6964C8
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Feb 2023 14:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjBNNfh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Feb 2023 08:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjBNNfg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Feb 2023 08:35:36 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8A025958;
        Tue, 14 Feb 2023 05:35:34 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PGMcJ1Qq7z67HtH;
        Tue, 14 Feb 2023 21:33:52 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 14 Feb
 2023 13:35:31 +0000
Date:   Tue, 14 Feb 2023 13:35:31 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kees Cook <keescook@chromium.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, Fan Ni <fan.ni@samsung.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 00/20] CXL RAM and the 'Soft Reserved' => 'System
 RAM' default
Message-ID: <20230214133531.00000cf7@Huawei.com>
In-Reply-To: <Y+p/2S4rnrOOyZ8w@memverge.com>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
        <Y+p/2S4rnrOOyZ8w@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 13 Feb 2023 13:22:17 -0500
Gregory Price <gregory.price@memverge.com> wrote:

> On Fri, Feb 10, 2023 at 01:05:21AM -0800, Dan Williams wrote:
> > Changes since v1: [1]
> > [... snip ...]  
> 
> For a single attached device - I have been finding general success.
> 
> For multiple attached devices, I'm seeing some strange behaviors.
> 
> With multiple root ports, I got some stack traces before deciding
> I needed multiple CMFW to do this "correctly", and just attached
> multiple pxb-cxl to the root bus.

Hmm. I should get on with doing multiple HDM decoders in the host
bridge at least. (also useful to support in switch and EP obviously)

> 
> Obviously this configuration is "not great", and some form of
> "impossible in the real world", but it's worth examining i think.

Seems reasonable simplification of what you might see on a 3 socket
system.  Host bridge and CFMWS per socket.

> 
> /opt/qemu-cxl/bin/qemu-system-x86_64 \
> -drive file=/data/qemu/images/pool/pool1.qcow2,format=qcow2,index=0,media=disk,id=hd \
> -m 4G,slots=4,maxmem=16G \
> -smp 4 \
> -machine type=q35,accel=kvm,cxl=on \
> -enable-kvm \
> -nographic \
> -netdev bridge,id=hn0,br=virbr0 \
> -device virtio-net-pci,netdev=hn0,id=nic1,mac=52:54:00:12:34:56 \
> -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
> -device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=191 \
> -device pxb-cxl,id=cxl.2,bus=pcie.0,bus_nr=230 \
> -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
> -device cxl-rp,id=rp1,bus=cxl.1,chassis=0,port=1,slot=1 \
> -device cxl-rp,id=rp2,bus=cxl.2,chassis=0,port=2,slot=2 \
> -object memory-backend-ram,id=mem0,size=4G \
> -object memory-backend-ram,id=mem1,size=4G \
> -object memory-backend-ram,id=mem2,size=4G \
> -device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0 \
> -device cxl-type3,bus=rp1,volatile-memdev=mem1,id=cxl-mem1 \
> -device cxl-type3,bus=rp2,volatile-memdev=mem2,id=cxl-mem2 \
> -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G,cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.size=4G,cxl-fmw.2.targets.0=cxl.2,cxl-fmw.2.size=4G
> 
> The goal here should be to have 3 different memory expanders have their
> regions created and mapped to 3 different numa nodes.
> 
> One piece i'm not confident about is my CFMW's
> (listed more readably:)
> 
> -M cxl-fmw.0.targets.0=cxl.0,
>    cxl-fmw.0.size=4G,
>    cxl-fmw.1.targets.0=cxl.1,
>    cxl-fmw.1.size=4G,
>    cxl-fmw.2.targets.0=cxl.2,
>    cxl-fmw.2.size=4G
> 
> should targets in this case be targets.0/1/2, or all of them targets.0?

targets.0 for all of them.  Fairly sure it will moan at you if you don't
do that as some of the targets array for each cfmws will be un specified.

> 
> Either way, i would expect 3 root decoders, and 3 memory devices
> 
> [root@fedora ~]# ls /sys/bus/cxl/devices/
> decoder0.0  decoder1.0  decoder4.0  endpoint4  mem0  nvdimm-bridge0  port3
> decoder0.1  decoder2.0  decoder5.0  endpoint5  mem1  port1           root0
> decoder0.2  decoder3.0  decoder6.0  endpoint6  mem2  port2
> 
> I see the devices I expect, but i would expect the following:
> (cxl list output at the bottom)
> 
> decoder0.0 -> mem0
> decoder0.1 -> mem1
> decoder0.2 -> mem2

I don't think there is any enforcement of ordering across various elements.
It just depends on exact ordering of probe calls that are racing.


> 
> root0 -> [decoder0.0, 0.1, 0.2]
> root0 -> [port1, 2, 3]
> port1 -> mem0
> port2 -> mem1
> port3 -> mem2
> 
> Really i see these decoders and device mappings setup:
> port1 -> mem2
> port2 -> mem1
> port3 -> mem0
> 
> Therefore I should expect
> decoder0.0 -> mem2
> decoder0.1 -> mem1
> decoder0.2 -> mem0
> 
> This bears out: attempting to use any other combination produces ndctl errors.
> 
> So the numbers are backwards, maybe that's relevant, maybe it's not.
> The devices are otherwise completely the same, so for the most part
> everything might "just work".  Lets keep testing.
> 
> 
> [root@fedora ~]# cat create_region.sh
> ./ndctl/build/cxl/cxl \
>   create-region \
>   -m \
>   -t ram \
>   -d decoder0.$1 \
>   -w 1 \
>   -g 4096 \
>   mem$2
> 
> [root@fedora ~]# ./create_region.sh 2 0
> [   34.424931] cxl_region region2: Bypassing cpu_cache_invalidate_memregion() for testing!
> {
>   "region":"region2",
>   "resource":"0x790000000",
>   "size":"4.00 GiB (4.29 GB)",
>   "type":"ram",
>   "interleave_ways":1,
>   "interleave_granularity":4096,
>   "decode_state":"commit",
>   "mappings":[
>     {
>       "position":0,
>       "memdev":"mem0",
>       "decoder":"decoder4.0"
>     }
>   ]
> }
> cxl region: cmd_create_region: created 1 region
> 
> [   34.486668] Fallback order for Node 3: 3 0
> [   34.487568] Built 1 zonelists, mobility grouping on.  Total pages: 979669
> [   34.488206] Policy zone: Normal
> [   34.501938] Fallback order for Node 0: 0 3
> [   34.502405] Fallback order for Node 1: 1 3 0
> [   34.502832] Fallback order for Node 2: 2 3 0
> [   34.503251] Fallback order for Node 3: 3 0
> [   34.503649] Built 2 zonelists, mobility grouping on.  Total pages: 1012437
> [   34.504296] Policy zone: Normal
> 
> 
> 
> Cool, looks good.  Lets try mem1
> 
> 
> 
> [root@fedora ~]# ./create_region.sh 1 1
> 
> [   98.787029] Fallback order for Node 2: 2 3 0
> [   98.787630] Built 2 zonelists, mobility grouping on.  Total pages: 2019798
> [   98.788483] Policy zone: Normal
> [  128.301580] Fallback order for Node 0: 0 2 3
> [  128.302084] Fallback order for Node 1: 1 3 2 0
> [  128.302547] Fallback order for Node 2: 2 3 0
> [  128.303009] Fallback order for Node 3: 3 2 0
> [  128.303436] Built 3 zonelists, mobility grouping on.  Total pages: 2052566
> [  128.304071] Policy zone: Normal
> [ .... wait 20-30 more seconds .... ]
> {
>   "region":"region1",
>   "resource":"0x690000000",
>   "size":"4.00 GiB (4.29 GB)",
>   "type":"ram",
>   "interleave_ways":1,
>   "interleave_granularity":4096,
>   "decode_state":"commit",
>   "mappings":[
>     {
>       "position":0,
>       "memdev":"mem1",
>       "decoder":"decoder5.0"
>     }
>   ]
> }
> cxl region: cmd_create_region: created 1 region
> 
> 
> This takes a LONG time to complete. Maybe that's expected, I don't know.
> 
> 
> Lets online mem2.
> 
> 
> [root@fedora ~]# ./create_region.sh 0 2
> extra data[7]: 0x0000000000000000
> emulation failure
> RAX=0000000000000000 RBX=ffff8a6f90006800 RCX=0000000000100001 RDX=0000000080100010
> RSI=ffffca291a400000 RDI=0000000040000000 RBP=ffff9684c0017a60 RSP=ffff9684c0017a30
> R8 =ffff8a6f90006800 R9 =0000000000100001 R10=0000000000000000 R11=0000000000000001
> R12=ffffca291a400000 R13=0000000000100001 R14=0000000000000000 R15=0000000080100010
> RIP=ffffffffb71c5831 RFL=00010006 [-----P-] CPL=0 II=0 A20=1 SMM=0 HLT=0
> ES =0000 0000000000000000 ffffffff 00c00000
> CS =0010 0000000000000000 ffffffff 00a09b00 DPL=0 CS64 [-RA]
> SS =0018 0000000000000000 ffffffff 00c09300 DPL=0 DS   [-WA]
> DS =0000 0000000000000000 ffffffff 00c00000
> FS =0000 00007fd03025db40 ffffffff 00c00000
> GS =0000 ffff8a6a7bd00000 ffffffff 00c00000
> LDT=0000 0000000000000000 ffffffff 00c00000
> TR =0040 fffffe46e6e25000 00004087 00008b00 DPL=0 TSS64-busy
> GDT=     fffffe46e6e23000 0000007f
> IDT=     fffffe0000000000 00000fff
> CR0=80050033 CR2=00005604371ab0c8 CR3=0000000102ece000 CR4=000006e0
> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000
> DR6=00000000fffe0ff0 DR7=0000000000000400
> EFER=0000000000000d01
> Code=83 ec 08 81 e7 00 00 00 40 74 2c 48 89 d0 48 89 ca 4c 89 c9 <f0> 48 0f c7 4e 20 0f 84 85 00 00 00 f3 90 48 83 c4 08 31 c0 5b 41 5c 41 5d 41 5e 41 5f 5d
> 
> 
> Well that seems bad lol.  I'm not sure what to make of this since my
> scrollback cuts off and the machine completely locks up.  I have never
> seen "emulation failure" before.
> 
> 
> Reboot and attempt to online that region by itself:
> 
> [root@fedora ~]# ./create_region.sh 0 2
> [   21.292598] cxl_region region0: Bypassing cpu_cache_invalidate_memregion() for testing!
> [   21.341753] Fallback order for Node 1: 1 0
> [   21.342462] Built 1 zonelists, mobility grouping on.  Total pages: 979670
> [   21.343085] Policy zone: Normal
> [   21.355166] Fallback order for Node 0: 0 1
> [   21.355613] Fallback order for Node 1: 1 0
> [   21.356009] Fallback order for Node 2: 2 1 0
> [   21.356441] Fallback order for Node 3: 3 1 0
> [   21.356874] Built 2 zonelists, mobility grouping on.  Total pages: 1012438
> [   21.357501] Policy zone: Normal
> {
>   "region":"region0",
>   "resource":"0x590000000",
>   "size":"4.00 GiB (4.29 GB)",
>   "type":"ram",
>   "interleave_ways":1,
>   "interleave_granularity":4096,
>   "decode_state":"commit",
>   "mappings":[
>     {
>       "position":0,
>       "memdev":"mem2",
>       "decoder":"decoder6.0"
>     }
>   ]
> }
> cxl region: cmd_create_region: created 1 region
> 
> 
> That works fine, and works just like onlining the first region (2,0).
> 
> This suggests the issue is actually creating multiple regions in this
> topology.
> 
> 
> 
> Bonus round: booting with memhp_default_state=offline
> 
> All regions successfully get created without error.
> 
> 
> 
> I have a few guesses, but haven't dived in yet:
> 
> 1) There's a QEMU error in the way this configuration routes to various
>    components of the CXL structure, and/or multiple pxb-cxl's do bad
>    things and I should feel bad for doing this configuration.

Nothing looks like it should be broken in your command line etc.
There may well be a bug in qemu though.
> 
> 2) There's something going on when creating the topology, leading to the
>    inverted [decoder0.2, mem0], [decoder0.1, mem1], [decoder0.0, mem2]
>    mappings, leading to inconsistent device control.  Or I'm making a
>    bad assumption and this is expected behavior.

Expected I think.

> 
> 3) The memory block creation / online code is getting hung up somewhere.
>    Why does the second region take forever to online?

Maybe try some smaller devices, just in case it's running out of memory somewhere.

> 
> 4) Something else completely.
> 
> 
> My gut at the moment tells me my configuration is bad, but i have no
> idea why.  Anyone with an idea on what I should look for, let me know.
> 
> 
> cxl list output for completeness:
> 
> [root@fedora ~]# ./ndctl/build/cxl/cxl list -vvvv
> [
>   {
>     "bus":"root0",
>     "provider":"ACPI.CXL",
>     "nr_dports":3,
>     "dports":[
>       {
>         "dport":"pci0000:e6",
>         "alias":"ACPI0016:00",
>         "id":230
>       },
>       {
>         "dport":"pci0000:bf",
>         "alias":"ACPI0016:01",
>         "id":191
>       },
>       {
>         "dport":"pci0000:34",
>         "alias":"ACPI0016:02",
>         "id":52
>       }
>     ],
>     "ports:root0":[
>       {
>         "port":"port1",
>         "host":"pci0000:e6",
>         "depth":1,
>         "nr_dports":1,
>         "dports":[
>           {
>             "dport":"0000:e6:00.0",
>             "id":2
>           }
>         ],
>         "endpoints:port1":[
>           {
>             "endpoint":"endpoint5",
>             "host":"mem1",
>             "depth":2,
>             "memdev":{
>               "memdev":"mem1",
>               "ram_size":4294967296,
>               "serial":0,
>               "host":"0000:e7:00.0",
>               "partition_info":{
>                 "total_size":4294967296,
>                 "volatile_only_size":4294967296,
>                 "persistent_only_size":0,
>                 "partition_alignment_size":0
>               }
>             },
>             "decoders:endpoint5":[
>               {
>                 "decoder":"decoder5.0",
>                 "interleave_ways":1,
>                 "state":"disabled"
>               }
>             ]
>           }
>         ],
>         "decoders:port1":[
>           {
>             "decoder":"decoder1.0",
>             "interleave_ways":1,
>             "state":"disabled",
>             "nr_targets":1,
>             "targets":[
>               {
>                 "target":"0000:e6:00.0",
>                 "position":0,
>                 "id":2
>               }
>             ]
>           }
>         ]
>       },
>       {
>         "port":"port3",
>         "host":"pci0000:34",
>         "depth":1,
>         "nr_dports":1,
>         "dports":[
>           {
>             "dport":"0000:34:00.0",
>             "id":0
>           }
>         ],
>         "endpoints:port3":[
>           {
>             "endpoint":"endpoint4",
>             "host":"mem0",
>             "depth":2,
>             "memdev":{
>               "memdev":"mem0",
>               "ram_size":4294967296,
>               "serial":0,
>               "host":"0000:35:00.0",
>               "partition_info":{
>                 "total_size":4294967296,
>                 "volatile_only_size":4294967296,
>                 "persistent_only_size":0,
>                 "partition_alignment_size":0
>               }
>             },
>             "decoders:endpoint4":[
>               {
>                 "decoder":"decoder4.0",
>                 "interleave_ways":1,
>                 "state":"disabled"
>               }
>             ]
>           }
>         ],
>         "decoders:port3":[
>           {
>             "decoder":"decoder3.0",
>             "interleave_ways":1,
>             "state":"disabled",
>             "nr_targets":1,
>             "targets":[
>               {
>                 "target":"0000:34:00.0",
>                 "position":0,
>                 "id":0
>               }
>             ]
>           }
>         ]
>       },
>       {
>         "port":"port2",
>         "host":"pci0000:bf",
>         "depth":1,
>         "nr_dports":1,
>         "dports":[
>           {
>             "dport":"0000:bf:00.0",
>             "id":1
>           }
>         ],
>         "endpoints:port2":[
>           {
>             "endpoint":"endpoint6",
>             "host":"mem2",
>             "depth":2,
>             "memdev":{
>               "memdev":"mem2",
>               "ram_size":4294967296,
>               "serial":0,
>               "host":"0000:c0:00.0",
>               "partition_info":{
>                 "total_size":4294967296,
>                 "volatile_only_size":4294967296,
>                 "persistent_only_size":0,
>                 "partition_alignment_size":0
>               }
>             },
>             "decoders:endpoint6":[
>               {
>                 "decoder":"decoder6.0",
>                 "interleave_ways":1,
>                 "state":"disabled"
>               }
>             ]
>           }
>         ],
>         "decoders:port2":[
>           {
>             "decoder":"decoder2.0",
>             "interleave_ways":1,
>             "state":"disabled",
>             "nr_targets":1,
>             "targets":[
>               {
>                 "target":"0000:bf:00.0",
>                 "position":0,
>                 "id":1
>               }
>             ]
>           }
>         ]
>       }
>     ],
>     "decoders:root0":[
>       {
>         "decoder":"decoder0.0",
>         "resource":23890755584,
>         "size":4294967296,
>         "interleave_ways":1,
>         "max_available_extent":4294967296,
>         "pmem_capable":true,
>         "volatile_capable":true,
>         "accelmem_capable":true,
>         "nr_targets":1,
>         "targets":[
>           {
>             "target":"pci0000:34",
>             "alias":"ACPI0016:02",
>             "position":0,
>             "id":52
>           }
>         ]
>       },
>       {
>         "decoder":"decoder0.1",
>         "resource":28185722880,
>         "size":4294967296,
>         "interleave_ways":1,
>         "max_available_extent":4294967296,
>         "pmem_capable":true,
>         "volatile_capable":true,
>         "accelmem_capable":true,
>         "nr_targets":1,
>         "targets":[
>           {
>             "target":"pci0000:bf",
>             "alias":"ACPI0016:01",
>             "position":0,
>             "id":191
>           }
>         ]
>       },
>       {
>         "decoder":"decoder0.2",
>         "resource":32480690176,
>         "size":4294967296,
>         "interleave_ways":1,
>         "max_available_extent":4294967296,
>         "pmem_capable":true,
>         "volatile_capable":true,
>         "accelmem_capable":true,
>         "nr_targets":1,
>         "targets":[
>           {
>             "target":"pci0000:e6",
>             "alias":"ACPI0016:00",
>             "position":0,
>             "id":230
>           }
>         ]
>       }
>     ]
>   }
> ]

