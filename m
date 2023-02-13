Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9165C694F24
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Feb 2023 19:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjBMSXB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Feb 2023 13:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBMSWw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2023 13:22:52 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3C31A96E;
        Mon, 13 Feb 2023 10:22:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itmM3/dR0f93HevGb3FlhC2mtBaNJb8xbSsnteAUPovT0Mv8WCSpbtUbIJ0oFm4Wc+f354cWd0zjFQ6E6Sd15WRXlNuQf2VCD2VqE3V/Vr/z/9uP4su1LOQZJumHmTLFLTs01/gx1hKuxOss0IXbbAAJXsRT003kwJl04fqwL7Lt+VidU8XG+NLwjJqyXM2HHi7dgIbY+vgW6FWnqMPTIxhybwry77LHZjHMfilWTwAro0PX+NloGEg/jztutFXUJfl9XHM6R6wp/yN+6PVfw8N++gAnlAFn5IfOo6Zf8cmQhbzKWSCaUBwF7P38HXnY9KzORvK4uVqcrxy+HNxmxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZ8gFfR9Yph6H0hyfjJASRSXHdy74xMPSppr95Tpchs=;
 b=JyOCiYRGK1RQ1Q/Jw4Gx8TwZrkV+YxhXMtRDpFlVBNE0EC4CH3d+5EF73YBe4ABZ1s5SbpwYqGQF5VdNE6z4L+jo65pS2jH7RtQhMcST4WftE9XsdK6kr7V5KV3jBrPcHE3MScIvrCazHxaK1WCJwjCm6zi61NM9qaWh3J7tNrRB8A6Ex1pE+t0pBKtQHGo2ORGZpc3IFNgiwj6AnDlkjM+1y1hy0bUpN+O8YUOKfZdLpNGzBTtdaymVajlZoAoi4lSeCS9lKwaxSoZeMuXSgHXiGJ/XEi9YfPV5pqoNBM+DhTQcWgtUeKEtGfSwGmW+oPIHaIWBkaUGwTUftu+swg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZ8gFfR9Yph6H0hyfjJASRSXHdy74xMPSppr95Tpchs=;
 b=y96aajLB4tOLH+yHzXVG1LjnFeWSHfGdZXiNc49vM1Q35Yq4GaOcEap5ujqjCH2+06z2K7WDvAipzqYdloegHCGYDWt45DliCTLboLKfs/RlRm9GAcRARXl7fF6SbCvbTQU3/7fwdUSIFZtWBQmzHDmImHo9tEEV1HvAQzcoHFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by DM8PR17MB5031.namprd17.prod.outlook.com (2603:10b6:8:29::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 18:22:28 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%3]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 18:22:28 +0000
Date:   Mon, 13 Feb 2023 13:22:17 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, Fan Ni <fan.ni@samsung.com>,
        linux-mm@kvack.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 00/20] CXL RAM and the 'Soft Reserved' => 'System RAM'
 default
Message-ID: <Y+p/2S4rnrOOyZ8w@memverge.com>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BYAPR06CA0024.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::37) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|DM8PR17MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: df99428a-4317-4170-aa0f-08db0def4320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r8WT7igO3ayhAr9+dErjh+MXRMgcNdSAE00NahcxIra+LW9PTwQEibmFhMpaX7sLtO1jqklbCP8x/AuWEhIFrA0UAZIp6Lweh19ijbgwUBVN9zXm7Rcp3W2Texih3s59LYmbkEE43V1cRZ2RdaB4LNHxQrLfXm9/12+729c8jJbqifBQxbw3yARG+b2/uxXrgOH7YwfslrtpqgKXAmYs8lt+PeDqJUgJusGC9nbokqAmYIP2NxdNh8+iJ2dtjQnI7YTGqhC8Tl70SfvfzCmDo4tyrhLxUREXxu+QpmbZScbEdP/bwVkD4Q8ub8wINFoPQ+qVIHk6VZoiRlSNgKugxHRnykTSUjpERWBTo5OONOKsIfkaAAD5UgXEEUD9gb+JIhIS5QgZ068JhLa06ALbOwfKp4jlH1I5hJxu5WdPml3upOnzdn7ogFn1CgJxkBu/5HeAWKnLkmI0wLge68gSqc9LZBoTelvax7JeFWDIMzzlPW/NaUuULpTm8jYWzmWbkEQxf8sENH9heIH7iQ2ZXoDy6hoji9KXBxQuMjNGDgse7rOPA+qiTs1E5yLUoxQgry3ZBx42f8mqTXOnrJOv2hB3hSyiu0Hr4xvaegwCSAcnM7RfGNrdYKfy18re6eG21VIcDFMlLvfUc0lfpTH46A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(376002)(39830400003)(136003)(366004)(451199018)(36756003)(2906002)(8936002)(316002)(30864003)(44832011)(7416002)(5660300002)(41300700001)(6916009)(66476007)(4326008)(66556008)(8676002)(86362001)(66946007)(38100700002)(54906003)(83380400001)(2616005)(6486002)(6666004)(478600001)(6506007)(6512007)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6FfT22r/eIIlx8XdiJ6FEoLYdN6Nq2fhHAesBxyoT2FOaQZ1hp6/mx7n2rQU?=
 =?us-ascii?Q?JqR14RrOs1A4nsAGQzOoEC7h545fgxcEkYEWwVkfFSFNV7mxJzL6PftFvD6B?=
 =?us-ascii?Q?er/VTQQG/DI19aEPUNP+KI3fvMbb5CRbvSHjiGoBYL47qcuaR/xiCkweKRZ5?=
 =?us-ascii?Q?s/Aby+P1Aghx9UAKBrU1TmxP53NOy2PcECYEs+/yBV0DLy9FeUqmM8DdpYNG?=
 =?us-ascii?Q?uZ97AVxciYZZFGY9vUeyz/lCnwJYf6b2SFvOGfnfML9w3FJ9d8q4UUm6rktW?=
 =?us-ascii?Q?VPUBhDznAdRVydqFQjcqfpVguNLkv+6erogx2BsEWOHVnznzV3Nc85wr7QpY?=
 =?us-ascii?Q?kfkmLhozlpkt11OJWiF98xH4VviOsY6g3Ylz6fG+HfJ9Jp+ep/TAJNnaHjO0?=
 =?us-ascii?Q?Hqq4Y59JFjOyI7dJn28YnlYK2szChgwbaGMmzQTzrNAbifmXET/gtaf2pmHY?=
 =?us-ascii?Q?ZEw4eNKEUKf3BRm9XTom1WaKfa0OSex1hP1MXhcFEs0Rq4Rlz1nx4CTHlHKQ?=
 =?us-ascii?Q?HmFscdCCUcnPHNYJ+r/9FznxDg/6cJ7/lLJQEvA52Ryma2ohT7jVq6gtYyZT?=
 =?us-ascii?Q?zsCbEjb/J5zf4CjJ3P60MRSI9m0oMbygabFV5bc1A8rHzM/5fx5gHmuGljqT?=
 =?us-ascii?Q?LUIVsVFpE8nxyjR2nnTN3BAwuciWNH4dydbEvBcXE5wGIWzt4qdDoIaSszo7?=
 =?us-ascii?Q?GdVdKL/nFPQ12cGpmk8C1G7CtH0VgNdO4hdt5vS8Im8Ycy2yZ1z9Xz/sUgfD?=
 =?us-ascii?Q?pzDJ7q+Ob3Gw4olxDit0AGgo23Xaz0KGvUeiQA6+rz3AMYFl9+jMCpIEbWxN?=
 =?us-ascii?Q?fl16Y0YxOldBfyGkXfx2UsSqRbwUVoL/PRf7m+lC/RL4B5ooyVTRM6nA5wWb?=
 =?us-ascii?Q?S8Y2+zGX2127fkd0vbE/h5PPUA5q3wjdT9aSc3DToElAq4SnpFcvzs+q6gSp?=
 =?us-ascii?Q?LzDIBSEE2t/xEQ+VJEOPo/AUk3ZUPq/9Pl8HVTflSwPBnyGdGCgYbojuRHDN?=
 =?us-ascii?Q?C75FGzIzKRGqbewlHFv9QYL1mvTY/uTuS5kWdWUaVL5hXH1T9fRDZIwupvfY?=
 =?us-ascii?Q?DDCOZqvk8b6bQMTDV4kbK0bKv5+DF+zC+Z3QrErSBbs6cs+VeQyDLqpCLvCL?=
 =?us-ascii?Q?kjHbzygUW3Ndp4Ztx2mL/8tfINrzFACiWSQAk139iLwCPp3AcL9/6yyFynTw?=
 =?us-ascii?Q?UcqBKRXVeoYNESi3MuPsywa2IKD9TDv0RqFQKl5HDsz21FyGwRoh75IXyqVI?=
 =?us-ascii?Q?23v3iPjNKmpHI/5vdHUDmm1Opefn07kOUEazPCLum7/XXTkpNz3ECTZxvl6f?=
 =?us-ascii?Q?K6je/omDv0duHN27mgVILQ0raOJejUu4vcXIcBAw8Jf+Nv3Lt80cibZ+F+75?=
 =?us-ascii?Q?i//smYF+jJP7+P8yQ3Z3mEO9M8IH3wAYZnoGjGgB+YShWzxtQ9XhDQC1utp1?=
 =?us-ascii?Q?2otVWOQU4Ha7HC8GOnHg1Qs42WZTbEDLcZnTkBPx+sY8n+LAOTpLcNpPHthI?=
 =?us-ascii?Q?c2XU0YeIaCoNyLoBk7HpBKwxMshxJx7YmnyyEZrsqsfa2A8plXIOy6pBan+A?=
 =?us-ascii?Q?aPUFquZkCVDOIE2JefCV6AFwsWBZGj/dcTVnHNJe383cITBS1dspzQ4LBPq2?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df99428a-4317-4170-aa0f-08db0def4320
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 18:22:28.0428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O7sfS+vyDWUcK+CFeW3VcmP9c+Bs1p9JtsA7isJzHzVJMRsmGbna7ZOIobyUF0RlnIIuPcUZPeYMTtX21cbjKP49+r4YNE5PPXvwa0y46yI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR17MB5031
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 10, 2023 at 01:05:21AM -0800, Dan Williams wrote:
> Changes since v1: [1]
> [... snip ...]

For a single attached device - I have been finding general success.

For multiple attached devices, I'm seeing some strange behaviors.

With multiple root ports, I got some stack traces before deciding
I needed multiple CMFW to do this "correctly", and just attached
multiple pxb-cxl to the root bus.

Obviously this configuration is "not great", and some form of
"impossible in the real world", but it's worth examining i think.

/opt/qemu-cxl/bin/qemu-system-x86_64 \
-drive file=/data/qemu/images/pool/pool1.qcow2,format=qcow2,index=0,media=disk,id=hd \
-m 4G,slots=4,maxmem=16G \
-smp 4 \
-machine type=q35,accel=kvm,cxl=on \
-enable-kvm \
-nographic \
-netdev bridge,id=hn0,br=virbr0 \
-device virtio-net-pci,netdev=hn0,id=nic1,mac=52:54:00:12:34:56 \
-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=191 \
-device pxb-cxl,id=cxl.2,bus=pcie.0,bus_nr=230 \
-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
-device cxl-rp,id=rp1,bus=cxl.1,chassis=0,port=1,slot=1 \
-device cxl-rp,id=rp2,bus=cxl.2,chassis=0,port=2,slot=2 \
-object memory-backend-ram,id=mem0,size=4G \
-object memory-backend-ram,id=mem1,size=4G \
-object memory-backend-ram,id=mem2,size=4G \
-device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0 \
-device cxl-type3,bus=rp1,volatile-memdev=mem1,id=cxl-mem1 \
-device cxl-type3,bus=rp2,volatile-memdev=mem2,id=cxl-mem2 \
-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G,cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.size=4G,cxl-fmw.2.targets.0=cxl.2,cxl-fmw.2.size=4G

The goal here should be to have 3 different memory expanders have their
regions created and mapped to 3 different numa nodes.

One piece i'm not confident about is my CFMW's
(listed more readably:)

-M cxl-fmw.0.targets.0=cxl.0,
   cxl-fmw.0.size=4G,
   cxl-fmw.1.targets.0=cxl.1,
   cxl-fmw.1.size=4G,
   cxl-fmw.2.targets.0=cxl.2,
   cxl-fmw.2.size=4G

should targets in this case be targets.0/1/2, or all of them targets.0?

Either way, i would expect 3 root decoders, and 3 memory devices

[root@fedora ~]# ls /sys/bus/cxl/devices/
decoder0.0  decoder1.0  decoder4.0  endpoint4  mem0  nvdimm-bridge0  port3
decoder0.1  decoder2.0  decoder5.0  endpoint5  mem1  port1           root0
decoder0.2  decoder3.0  decoder6.0  endpoint6  mem2  port2

I see the devices I expect, but i would expect the following:
(cxl list output at the bottom)

decoder0.0 -> mem0
decoder0.1 -> mem1
decoder0.2 -> mem2

root0 -> [decoder0.0, 0.1, 0.2]
root0 -> [port1, 2, 3]
port1 -> mem0
port2 -> mem1
port3 -> mem2

Really i see these decoders and device mappings setup:
port1 -> mem2
port2 -> mem1
port3 -> mem0

Therefore I should expect
decoder0.0 -> mem2
decoder0.1 -> mem1
decoder0.2 -> mem0

This bears out: attempting to use any other combination produces ndctl errors.

So the numbers are backwards, maybe that's relevant, maybe it's not.
The devices are otherwise completely the same, so for the most part
everything might "just work".  Lets keep testing.


[root@fedora ~]# cat create_region.sh
./ndctl/build/cxl/cxl \
  create-region \
  -m \
  -t ram \
  -d decoder0.$1 \
  -w 1 \
  -g 4096 \
  mem$2

[root@fedora ~]# ./create_region.sh 2 0
[   34.424931] cxl_region region2: Bypassing cpu_cache_invalidate_memregion() for testing!
{
  "region":"region2",
  "resource":"0x790000000",
  "size":"4.00 GiB (4.29 GB)",
  "type":"ram",
  "interleave_ways":1,
  "interleave_granularity":4096,
  "decode_state":"commit",
  "mappings":[
    {
      "position":0,
      "memdev":"mem0",
      "decoder":"decoder4.0"
    }
  ]
}
cxl region: cmd_create_region: created 1 region

[   34.486668] Fallback order for Node 3: 3 0
[   34.487568] Built 1 zonelists, mobility grouping on.  Total pages: 979669
[   34.488206] Policy zone: Normal
[   34.501938] Fallback order for Node 0: 0 3
[   34.502405] Fallback order for Node 1: 1 3 0
[   34.502832] Fallback order for Node 2: 2 3 0
[   34.503251] Fallback order for Node 3: 3 0
[   34.503649] Built 2 zonelists, mobility grouping on.  Total pages: 1012437
[   34.504296] Policy zone: Normal



Cool, looks good.  Lets try mem1



[root@fedora ~]# ./create_region.sh 1 1

[   98.787029] Fallback order for Node 2: 2 3 0
[   98.787630] Built 2 zonelists, mobility grouping on.  Total pages: 2019798
[   98.788483] Policy zone: Normal
[  128.301580] Fallback order for Node 0: 0 2 3
[  128.302084] Fallback order for Node 1: 1 3 2 0
[  128.302547] Fallback order for Node 2: 2 3 0
[  128.303009] Fallback order for Node 3: 3 2 0
[  128.303436] Built 3 zonelists, mobility grouping on.  Total pages: 2052566
[  128.304071] Policy zone: Normal
[ .... wait 20-30 more seconds .... ]
{
  "region":"region1",
  "resource":"0x690000000",
  "size":"4.00 GiB (4.29 GB)",
  "type":"ram",
  "interleave_ways":1,
  "interleave_granularity":4096,
  "decode_state":"commit",
  "mappings":[
    {
      "position":0,
      "memdev":"mem1",
      "decoder":"decoder5.0"
    }
  ]
}
cxl region: cmd_create_region: created 1 region


This takes a LONG time to complete. Maybe that's expected, I don't know.


Lets online mem2.


[root@fedora ~]# ./create_region.sh 0 2
extra data[7]: 0x0000000000000000
emulation failure
RAX=0000000000000000 RBX=ffff8a6f90006800 RCX=0000000000100001 RDX=0000000080100010
RSI=ffffca291a400000 RDI=0000000040000000 RBP=ffff9684c0017a60 RSP=ffff9684c0017a30
R8 =ffff8a6f90006800 R9 =0000000000100001 R10=0000000000000000 R11=0000000000000001
R12=ffffca291a400000 R13=0000000000100001 R14=0000000000000000 R15=0000000080100010
RIP=ffffffffb71c5831 RFL=00010006 [-----P-] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =0000 0000000000000000 ffffffff 00c00000
CS =0010 0000000000000000 ffffffff 00a09b00 DPL=0 CS64 [-RA]
SS =0018 0000000000000000 ffffffff 00c09300 DPL=0 DS   [-WA]
DS =0000 0000000000000000 ffffffff 00c00000
FS =0000 00007fd03025db40 ffffffff 00c00000
GS =0000 ffff8a6a7bd00000 ffffffff 00c00000
LDT=0000 0000000000000000 ffffffff 00c00000
TR =0040 fffffe46e6e25000 00004087 00008b00 DPL=0 TSS64-busy
GDT=     fffffe46e6e23000 0000007f
IDT=     fffffe0000000000 00000fff
CR0=80050033 CR2=00005604371ab0c8 CR3=0000000102ece000 CR4=000006e0
DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000
DR6=00000000fffe0ff0 DR7=0000000000000400
EFER=0000000000000d01
Code=83 ec 08 81 e7 00 00 00 40 74 2c 48 89 d0 48 89 ca 4c 89 c9 <f0> 48 0f c7 4e 20 0f 84 85 00 00 00 f3 90 48 83 c4 08 31 c0 5b 41 5c 41 5d 41 5e 41 5f 5d


Well that seems bad lol.  I'm not sure what to make of this since my
scrollback cuts off and the machine completely locks up.  I have never
seen "emulation failure" before.


Reboot and attempt to online that region by itself:

[root@fedora ~]# ./create_region.sh 0 2
[   21.292598] cxl_region region0: Bypassing cpu_cache_invalidate_memregion() for testing!
[   21.341753] Fallback order for Node 1: 1 0
[   21.342462] Built 1 zonelists, mobility grouping on.  Total pages: 979670
[   21.343085] Policy zone: Normal
[   21.355166] Fallback order for Node 0: 0 1
[   21.355613] Fallback order for Node 1: 1 0
[   21.356009] Fallback order for Node 2: 2 1 0
[   21.356441] Fallback order for Node 3: 3 1 0
[   21.356874] Built 2 zonelists, mobility grouping on.  Total pages: 1012438
[   21.357501] Policy zone: Normal
{
  "region":"region0",
  "resource":"0x590000000",
  "size":"4.00 GiB (4.29 GB)",
  "type":"ram",
  "interleave_ways":1,
  "interleave_granularity":4096,
  "decode_state":"commit",
  "mappings":[
    {
      "position":0,
      "memdev":"mem2",
      "decoder":"decoder6.0"
    }
  ]
}
cxl region: cmd_create_region: created 1 region


That works fine, and works just like onlining the first region (2,0).

This suggests the issue is actually creating multiple regions in this
topology.



Bonus round: booting with memhp_default_state=offline

All regions successfully get created without error.



I have a few guesses, but haven't dived in yet:

1) There's a QEMU error in the way this configuration routes to various
   components of the CXL structure, and/or multiple pxb-cxl's do bad
   things and I should feel bad for doing this configuration.

2) There's something going on when creating the topology, leading to the
   inverted [decoder0.2, mem0], [decoder0.1, mem1], [decoder0.0, mem2]
   mappings, leading to inconsistent device control.  Or I'm making a
   bad assumption and this is expected behavior.

3) The memory block creation / online code is getting hung up somewhere.
   Why does the second region take forever to online?

4) Something else completely.


My gut at the moment tells me my configuration is bad, but i have no
idea why.  Anyone with an idea on what I should look for, let me know.


cxl list output for completeness:

[root@fedora ~]# ./ndctl/build/cxl/cxl list -vvvv
[
  {
    "bus":"root0",
    "provider":"ACPI.CXL",
    "nr_dports":3,
    "dports":[
      {
        "dport":"pci0000:e6",
        "alias":"ACPI0016:00",
        "id":230
      },
      {
        "dport":"pci0000:bf",
        "alias":"ACPI0016:01",
        "id":191
      },
      {
        "dport":"pci0000:34",
        "alias":"ACPI0016:02",
        "id":52
      }
    ],
    "ports:root0":[
      {
        "port":"port1",
        "host":"pci0000:e6",
        "depth":1,
        "nr_dports":1,
        "dports":[
          {
            "dport":"0000:e6:00.0",
            "id":2
          }
        ],
        "endpoints:port1":[
          {
            "endpoint":"endpoint5",
            "host":"mem1",
            "depth":2,
            "memdev":{
              "memdev":"mem1",
              "ram_size":4294967296,
              "serial":0,
              "host":"0000:e7:00.0",
              "partition_info":{
                "total_size":4294967296,
                "volatile_only_size":4294967296,
                "persistent_only_size":0,
                "partition_alignment_size":0
              }
            },
            "decoders:endpoint5":[
              {
                "decoder":"decoder5.0",
                "interleave_ways":1,
                "state":"disabled"
              }
            ]
          }
        ],
        "decoders:port1":[
          {
            "decoder":"decoder1.0",
            "interleave_ways":1,
            "state":"disabled",
            "nr_targets":1,
            "targets":[
              {
                "target":"0000:e6:00.0",
                "position":0,
                "id":2
              }
            ]
          }
        ]
      },
      {
        "port":"port3",
        "host":"pci0000:34",
        "depth":1,
        "nr_dports":1,
        "dports":[
          {
            "dport":"0000:34:00.0",
            "id":0
          }
        ],
        "endpoints:port3":[
          {
            "endpoint":"endpoint4",
            "host":"mem0",
            "depth":2,
            "memdev":{
              "memdev":"mem0",
              "ram_size":4294967296,
              "serial":0,
              "host":"0000:35:00.0",
              "partition_info":{
                "total_size":4294967296,
                "volatile_only_size":4294967296,
                "persistent_only_size":0,
                "partition_alignment_size":0
              }
            },
            "decoders:endpoint4":[
              {
                "decoder":"decoder4.0",
                "interleave_ways":1,
                "state":"disabled"
              }
            ]
          }
        ],
        "decoders:port3":[
          {
            "decoder":"decoder3.0",
            "interleave_ways":1,
            "state":"disabled",
            "nr_targets":1,
            "targets":[
              {
                "target":"0000:34:00.0",
                "position":0,
                "id":0
              }
            ]
          }
        ]
      },
      {
        "port":"port2",
        "host":"pci0000:bf",
        "depth":1,
        "nr_dports":1,
        "dports":[
          {
            "dport":"0000:bf:00.0",
            "id":1
          }
        ],
        "endpoints:port2":[
          {
            "endpoint":"endpoint6",
            "host":"mem2",
            "depth":2,
            "memdev":{
              "memdev":"mem2",
              "ram_size":4294967296,
              "serial":0,
              "host":"0000:c0:00.0",
              "partition_info":{
                "total_size":4294967296,
                "volatile_only_size":4294967296,
                "persistent_only_size":0,
                "partition_alignment_size":0
              }
            },
            "decoders:endpoint6":[
              {
                "decoder":"decoder6.0",
                "interleave_ways":1,
                "state":"disabled"
              }
            ]
          }
        ],
        "decoders:port2":[
          {
            "decoder":"decoder2.0",
            "interleave_ways":1,
            "state":"disabled",
            "nr_targets":1,
            "targets":[
              {
                "target":"0000:bf:00.0",
                "position":0,
                "id":1
              }
            ]
          }
        ]
      }
    ],
    "decoders:root0":[
      {
        "decoder":"decoder0.0",
        "resource":23890755584,
        "size":4294967296,
        "interleave_ways":1,
        "max_available_extent":4294967296,
        "pmem_capable":true,
        "volatile_capable":true,
        "accelmem_capable":true,
        "nr_targets":1,
        "targets":[
          {
            "target":"pci0000:34",
            "alias":"ACPI0016:02",
            "position":0,
            "id":52
          }
        ]
      },
      {
        "decoder":"decoder0.1",
        "resource":28185722880,
        "size":4294967296,
        "interleave_ways":1,
        "max_available_extent":4294967296,
        "pmem_capable":true,
        "volatile_capable":true,
        "accelmem_capable":true,
        "nr_targets":1,
        "targets":[
          {
            "target":"pci0000:bf",
            "alias":"ACPI0016:01",
            "position":0,
            "id":191
          }
        ]
      },
      {
        "decoder":"decoder0.2",
        "resource":32480690176,
        "size":4294967296,
        "interleave_ways":1,
        "max_available_extent":4294967296,
        "pmem_capable":true,
        "volatile_capable":true,
        "accelmem_capable":true,
        "nr_targets":1,
        "targets":[
          {
            "target":"pci0000:e6",
            "alias":"ACPI0016:00",
            "position":0,
            "id":230
          }
        ]
      }
    ]
  }
]
