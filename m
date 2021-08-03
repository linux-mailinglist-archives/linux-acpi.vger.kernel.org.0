Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB0D3DE37B
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Aug 2021 02:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhHCAUB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Aug 2021 20:20:01 -0400
Received: from mail-bn8nam11on2088.outbound.protection.outlook.com ([40.107.236.88]:62529
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232540AbhHCAUA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Aug 2021 20:20:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBlNvE0H1L43nY92Kb9p8NpbHW7RAImFq5MI0Kscfnj120HkEdef0Kc6LWGBZuZ6Dq+UsQkDgHbg8XOkmaqXfI2n/Q7yKMf0L1S37BcB8i7+tOdoI9kVBEr7fniSS373GuBSANPy6JNSdNWz7QZm534Zlv8jJcjrcnCJdgTXyJ8B/cBtb76S5VWLsX6auN9HNZ1t2jly+Z0TcMvBBpqSbfvdK3TlBjMVX8gqXnFq7WONssNyWvOckw5PUNzkznL3RsrU+X4QIi5vHrSu/kxtiF50lRxkdo2yBg6CX7sbkddKcD5Pa7qEoV5wLvsSgHPm6hGI2eMybc9cW4EqWoUqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0I+N1DdZLUz4CSOYVmUnmbbMldkd0U43IRP1eRb2IQ=;
 b=BcsOmeCL4eViP0ndOu0R6SrLtOsSLL/ovDlfH+ua3j4PmzyWeLyHrvIpIMWXELyE+0Al/D4HkbrfMcokevohZMc8IiJwQLW3tzI6AtNaBpAKH8iRXZ8XCS4cLMEeF0JopVawyhWUbXckBdmpb7+GdLBfKrrZOuC2LQjU14/Dhd9VN0urIt8Flg1/+jBks0Fhm9iu739lQdjWjA6Eb3QIWTrP3s4UJOocfxkHIuuxqhoU+ITDx/Q5WS0otbMBa4GMvgKTJCYWPtwnTITKlHzuK5e5buIA4TMv9FXA3ZmLw3CAdmt/D8dnDSpede2/cpuS5PMkJagSVuwZ+Yb2mwfxIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0I+N1DdZLUz4CSOYVmUnmbbMldkd0U43IRP1eRb2IQ=;
 b=sSEnzpAVymi+v0w/6TpdwWe7KPwLFInzSYy4mclAYuu7fQ1tmGrdN9wCT2fGWCYz31p9yv0pZGtD3rwfcA5NZpDZfZi0xyDsTjgIZXEhG0EOTUrGqLaFAQxErrz1H1w6xG3ArDJnUCYX/0wkdklPqie56E86oeV4YPQSj8ibc1Q=
Received: from DM5PR16CA0013.namprd16.prod.outlook.com (2603:10b6:3:c0::23) by
 MWHPR12MB1917.namprd12.prod.outlook.com (2603:10b6:300:113::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Tue, 3 Aug
 2021 00:19:47 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::e9) by DM5PR16CA0013.outlook.office365.com
 (2603:10b6:3:c0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19 via Frontend
 Transport; Tue, 3 Aug 2021 00:19:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 00:19:46 +0000
Received: from hr-amd (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 2 Aug
 2021 19:19:43 -0500
Date:   Tue, 3 Aug 2021 08:20:18 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     Basavaraj Natikar <bnatikar@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        Stephen MacNeil <macneisj@gmail.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Prike Liang <prike.liang@amd.com>
Subject: Re: AMD laptops defaulting to S3 instead of S0ix (was amd_sfh)
Message-ID: <20210803002018.GH2563957@hr-amd>
References: <CALWF37bJU92DxcD4VhBxbS+X+EUv-UW2oY-ogwMyNyGAnn=0WA@mail.gmail.com>
 <309288ec-27ac-0321-dce5-e9ba2bbab7ed@redhat.com>
 <BN9PR12MB505286920B83D4C71AC81E3CA0EE9@BN9PR12MB5052.namprd12.prod.outlook.com>
 <e11ce06f-8a5d-345a-5113-dd8802e9a0b9@amd.com>
 <eab56fac-175b-29b7-f66b-398b6477f390@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eab56fac-175b-29b7-f66b-398b6477f390@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 086bf463-0796-4a84-9b96-08d95614668a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1917:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1917552CCB328D32081B6327ECF09@MWHPR12MB1917.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VdhPqMb4f22GbUALE9Lxscniapbo9lF71xxfPIou05U5cOmdsWFWrbvK5EkcZyYh+7U/HwpdjZPoheES8/eyDCLis9Y4pNdhyu4wAc1NKNzq2kNl7bJ90SPVzpMGD9b6g7JU8vI59J4omAAXlsW7kfaxiRulh+poYUC0p43+o4rHJwksC5KGTnkEmw128hka3Qv+TNAoLoF/BxAhoUOJonfE0vX2PKB6MsRNpZSMnpNub8XQGavMBDJ8VKhW1gCWfD5ad5A2fUU2MJqmrBN0cXUI0rEeEgGfTwOfyJAKLJL9z9dRXTMZGVaH4Xz7uVTzHGxKzxYzzCcUNeFRef0G9yAaP6aJ66bfv4841VppeAopCe6/mRs7LSfo1rEYrw6y27G8tVCTX6BFduXL41y23Q45xAaC+Eg2G0rk4eLrnW7MDYY7qMNJOdcyTYNdO1MvntV55V3hXdI+evo2bLt86Ru+kPS+mKC0DfPg8iqqD9evu+wYnwxKaprNWXxazVp62BeC0yrOGfGh2SiBgWDJDgVqwrcZHqdO9V1r01GAECoMHVnXUuQwgA0m/cy+IoSXeGYUgQTS/vmTdft3jzjPkAIlNVM9zKAuF5GMcps6Nz7ZbAnaOxBu6PAx6F8gaBdP5+l7sJ8pe02sP1EXM7A+Yujp4ORnxos/I91LgcR8VRRRY65+dezDTFwt09SNVZg9K8zI5iJkHpyZs7eD9nVVmRxooCnc1Q/OuMAApqHTS77OKdnUnHE4yaxVcYtI+s4Gzi33jDGclKXQ6Jntb8GBXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(46966006)(36840700001)(82310400003)(186003)(53546011)(6666004)(1076003)(36860700001)(336012)(2906002)(81166007)(5660300002)(426003)(4326008)(86362001)(356005)(33716001)(8936002)(30864003)(33656002)(6916009)(45080400002)(47076005)(26005)(8676002)(478600001)(83380400001)(70586007)(55016002)(70206006)(9686003)(316002)(82740400003)(16526019)(54906003)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 00:19:46.8330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 086bf463-0796-4a84-9b96-08d95614668a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1917
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

+ Prike

On Mon, Aug 02, 2021 at 01:43:01PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 8/2/21 11:34 AM, Basavaraj Natikar wrote:
> > On 8/1/2021 5:15 PM, Shah, Nehal-bakulchandra wrote:
> >> [AMD Official Use Only]
> >>
> >> Adding few more folks
> >>
> >> -----Original Message-----
> >> From: Hans de Goede <hdegoede@redhat.com> 
> >> Sent: Sunday, August 1, 2021 3:17 PM
> >> To: Stephen MacNeil <macneisj@gmail.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; Rafael J . Wysocki <rjw@rjwysocki.net>
> >> Cc: Linux PM <linux-pm@vger.kernel.org>; linux-acpi <linux-acpi@vger.kernel.org>
> >> Subject: AMD laptops defaulting to S3 instead of S0ix (was amd_sfh)
> >>
> >> Hi Rafael, Mario,
> >>
> >> Stephen is having an issue with a recent AMD laptop (a Lenovo Ideapad model) where Linux defaults to using S3/deep suspend instead of S0ix/s2idle.
> > 
> > Hi Hans, Et al.
> > 
> > Looks like the Lenovo platform Stephen MacNeil is using does not support the S2Idle as the FADT flags as not set (looking at the output of the script).
> 
> I believe it does, if it would not support s2idle at all, then this would not be offered as an option in the
> "cat /sys/power/mem_sleep" output.
> 
> Part of the problem seems to be that the system supports s2idle, but does not use it by default
> 
> > If sensors are not working after ACPI S3 resume, I am suspecting that it could be because the PM support is missing in the amd-sfh driver
> > (which is already WIP from my side).
> 
> Right, making sure the SFH code also works with S3 suspend is good regardless, but AFAIK most modern
> systems should use S01x / s2idle suspend by default.
> 
> Regards,
> 
> Hans
> 
> 
> 
> >> This is causing the sensors provided by the AMD Sensor Fusion Hub to stop working after a suspend/resume. Adding mem_sleep_default=s2idle to the kernel commandline fixes this.
> >>
> >> Do you have any idea what might be causing this ?
> >>
> >> Regards,
> >>
> >> Hans
> >>
> >>
> >>
> >> On 7/31/21 2:31 PM, Stephen MacNeil wrote:
> >>> I wrote Basavaraj Natikar the new maintainer of amd_sfh for the kernel, after sending the information he wanted his reply was...
> >>>
> >>>>> Thanks Stephen MacNeil,
> >>> On our hardware we do not see any amd_sfh issue with 5.14.0-rc2 kernel.
> >>>  
> >>> Could you please check with Lenovo, as we are not observing amd_sfh issue on our reference platforms too.
> >>>
> >>> Thanks,
> >>> Basavaraj
> >>> <<
> >>> looking at the information I sent him  i looks like the issue is (to 
> >>> me anyway)
> >>>
> >>> cat /sys/power/mem_sleep
> >>> [s2idle] deep
> >>>
> >>> without
> >>> cat /sys/power/mem_sleep
> >>> s2idle [deep]
> >>>
> >>>
> >>> this is the info he requested... any idea who else I can contact.
> >>> this is the output with and without the kernel param
> >>>
> >>>  
> >>>
> >>> Thanks a lot Stephen MacNeil  for the information.
> >>>
> >>>  
> >>>
> >>> Could you please provide me below information:-
> >>>
> >>> ·  what version of kernel is running.
> >>>
> >>> uname -a
> >>> Linux ideapad 5.14.0-051400rc2-generic #202107182230 SMP Sun Jul 18 
> >>> 22:34:12 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> >>>
> >>>
> >>> ·  Are you using latest patches from amd-sfh
> >>>
> >>> only the kernel
> >>>
> >>> ·  Could you please provide me output of /sys/power/mem_sleep
> >>>
> >>> with kernel option mem_sleep_default=s2idle
> >>>
> >>> cat /sys/power/mem_sleep
> >>> [s2idle] deep
> >>>
> >>> without
> >>> cat /sys/power/mem_sleep
> >>> s2idle [deep]
> >>>
> >>> ·  Could you please provide output of below script after installing 
> >>> "apt install iasl*". acpica-tools
> >>>
> >>> with kernel option mem_sleep_default=s2idle
> >>>
> >>> Intel ACPI Component Architecture
> >>> ASL+ Optimizing Compiler/Disassembler version 20190509
> >>> Copyright (c) 2000 - 2019 Intel Corporation
> >>>
> >>> File appears to be binary: found 265 non-ASCII characters, 
> >>> disassembling Binary file appears to be a valid ACPI table, 
> >>> disassembling Input file apic.dat, Length 0x138 (312) bytes
> >>> ACPI: APIC 0x0000000000000000 000138 (v02 LENOVO CB-01    00000000 
> >>> LENO 00000001) Acpi Data Table [APIC] decoded Formatted output:  
> >>> apic.dsl - 16071 bytes File appears to be binary: found 40 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file batb.dat, Length 0x4A (74) bytes
> >>> ACPI: BATB 0x0000000000000000 00004A (v02 LENOVO CB-01    00000000 
> >>> LENO 00000001) Unknown ACPI table signature [BATB], decoding ACPI 
> >>> table header only Acpi Data Table [BATB] decoded Formatted output:  
> >>> batb.dsl - 1274 bytes File appears to be binary: found 31 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file bgrt.dat, Length 0x38 (56) bytes
> >>> ACPI: BGRT 0x0000000000000000 000038 (v01 LENOVO CB-01    00000002 
> >>> LENO 00000001) Acpi Data Table [BGRT] decoded Formatted output:  
> >>> bgrt.dsl - 1606 bytes File appears to be binary: found 16 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file cdit.dat, Length 0x29 (41) bytes
> >>> ACPI: CDIT 0x0000000000000000 000029 (v01 LENOVO CB-01    00000001 
> >>> LENO 00000001) Unknown ACPI table signature [CDIT], decoding ACPI 
> >>> table header only Acpi Data Table [CDIT] decoded Formatted output:  
> >>> cdit.dsl - 1115 bytes File appears to be binary: found 2765 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file crat.dat, Length 0xB80 (2944) bytes
> >>> ACPI: CRAT 0x0000000000000000 000B80 (v01 LENOVO CB-01    00000001 
> >>> LENO 00000001) Unknown ACPI table signature [CRAT], decoding ACPI 
> >>> table header only Acpi Data Table [CRAT] decoded Formatted output:  
> >>> crat.dsl - 15424 bytes File appears to be binary: found 15189 
> >>> non-ASCII characters, disassembling Binary file appears to be a valid 
> >>> ACPI table, disassembling Input file dsdt.dat, Length 0xAE9B (44699) 
> >>> bytes
> >>> ACPI: DSDT 0x0000000000000000 00AE9B (v01 LENOVO AMD      00001000 
> >>> INTL 20180313) Pass 1 parse of [DSDT] Pass 2 parse of [DSDT] Parsing 
> >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> >>>
> >>> Parsing completed
> >>> Disassembly completed
> >>> ASL Output:    dsdt.dsl - 384071 bytes File appears to be binary: 
> >>> found 229 non-ASCII characters, disassembling Binary file appears to 
> >>> be a valid ACPI table, disassembling Input file facp.dat, Length 0x10C 
> >>> (268) bytes
> >>> ACPI: FACP 0x0000000000000000 00010C (v05 LENOVO CB-01    00000003 
> >>> LENO 00000001) Acpi Data Table [FACP] decoded Formatted output:  
> >>> facp.dsl - 10098 bytes File appears to be binary: found 59 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file facs.dat, Length 0x40 (64) bytes
> >>> ACPI: FACS 0x0000000000000000 000040
> >>> Acpi Data Table [FACS] decoded
> >>> Formatted output:  facs.dsl - 1368 bytes File appears to be binary: 
> >>> found 28 non-ASCII characters, disassembling Binary file appears to be 
> >>> a valid ACPI table, disassembling Input file fpdt.dat, Length 0x34 
> >>> (52) bytes
> >>> ACPI: FPDT 0x0000000000000000 000034 (v01 LENOVO CB-01    00000002 
> >>> LENO 00000001) Acpi Data Table [FPDT] decoded Formatted output:  
> >>> fpdt.dsl - 1452 bytes File appears to be binary: found 30 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file hpet.dat, Length 0x38 (56) bytes
> >>> ACPI: HPET 0x0000000000000000 000038 (v01 LENOVO CB-01    00000001 
> >>> LENO 00000001) Acpi Data Table [HPET] decoded Formatted output:  
> >>> hpet.dsl - 1865 bytes File appears to be binary: found 279 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file ivrs.dat, Length 0x1A4 (420) bytes
> >>> ACPI: IVRS 0x0000000000000000 0001A4 (v02 LENOVO CB-01    00000001 
> >>> LENO 00000001) Acpi Data Table [IVRS] decoded Formatted output:  
> >>> ivrs.dsl - 6001 bytes File appears to be binary: found 36 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file mcfg.dat, Length 0x3C (60) bytes
> >>> ACPI: MCFG 0x0000000000000000 00003C (v01 LENOVO CB-01    00000001 
> >>> LENO 00000001) Acpi Data Table [MCFG] decoded Formatted output:  
> >>> mcfg.dsl - 1526 bytes File appears to be binary: found 32 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file msdm.dat, Length 0x55 (85) bytes
> >>> ACPI: MSDM 0x0000000000000000 000055 (v03 LENOVO CB-01    00000000 
> >>> LENO 00000001) Acpi Data Table [MSDM] decoded Formatted output:  
> >>> msdm.dsl - 1557 bytes File appears to be binary: found 25 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file sbst.dat, Length 0x30 (48) bytes
> >>> ACPI: SBST 0x0000000000000000 000030 (v01 LENOVO CB-01    00000001 
> >>> LENO 00000001) Acpi Data Table [SBST] decoded Formatted output:  
> >>> sbst.dsl - 1282 bytes File appears to be binary: found 410 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file ssdt10.dat, Length 0x47F (1151) bytes
> >>> ACPI: SSDT 0x0000000000000000 00047F (v01 LENOVO AmdTable 00000001 
> >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
> >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> >>>
> >>> Parsing completed
> >>> Disassembly completed
> >>> ASL Output:    ssdt10.dsl - 5673 bytes File appears to be binary: 
> >>> found 708 non-ASCII characters, disassembling Binary file appears to 
> >>> be a valid ACPI table, disassembling Input file ssdt11.dat, Length 
> >>> 0xC1D (3101) bytes
> >>> ACPI: SSDT 0x0000000000000000 000C1D (v01 LENOVO AmdTable 00000001 
> >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
> >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> >>>
> >>> Parsing completed
> >>> Disassembly completed
> >>> ASL Output:    ssdt11.dsl - 15424 bytes File appears to be binary: 
> >>> found 848 non-ASCII characters, disassembling Binary file appears to 
> >>> be a valid ACPI table, disassembling Input file ssdt12.dat, Length 
> >>> 0x9AD (2477) bytes
> >>> ACPI: SSDT 0x0000000000000000 0009AD (v01 LENOVO AmdTable 00000001 
> >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
> >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> >>>
> >>> Parsing completed
> >>> Disassembly completed
> >>> ASL Output:    ssdt12.dsl - 12474 bytes File appears to be binary: 
> >>> found 9207 non-ASCII characters, disassembling Binary file appears to 
> >>> be a valid ACPI table, disassembling Input file ssdt1.dat, Length 
> >>> 0x7216 (29206) bytes
> >>> ACPI: SSDT 0x0000000000000000 007216 (v02 LENOVO AmdTable 00000002 
> >>> MSFT 04000000) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
> >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> >>>
> >>> Parsing completed
> >>> Disassembly completed
> >>> ASL Output:    ssdt1.dsl - 208699 bytes File appears to be binary: 
> >>> found 3968 non-ASCII characters, disassembling Binary file appears to 
> >>> be a valid ACPI table, disassembling Input file ssdt2.dat, Length 
> >>> 0x1500 (5376) bytes
> >>> ACPI: SSDT 0x0000000000000000 001500 (v01 LENOVO AmdTable 00000001 AMD  
> >>> 00000001) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
> >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> >>>
> >>> Parsing completed
> >>> Disassembly completed
> >>> ASL Output:    ssdt2.dsl - 59265 bytes File appears to be binary: 
> >>> found 449 non-ASCII characters, disassembling Binary file appears to 
> >>> be a valid ACPI table, disassembling Input file ssdt3.dat, Length 
> >>> 0x53A (1338) bytes
> >>> ACPI: SSDT 0x0000000000000000 00053A (v01 LENOVO Tpm2Tabl 00009999 
> >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
> >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> >>>
> >>> Parsing completed
> >>> Disassembly completed
> >>> ASL Output:    ssdt3.dsl - 10738 bytes File appears to be binary: 
> >>> found 474 non-ASCII characters, disassembling Binary file appears to 
> >>> be a valid ACPI table, disassembling Input file ssdt4.dat, Length 
> >>> 0x64C (1612) bytes
> >>> ACPI: SSDT 0x0000000000000000 00064C (v01 LENOVO AmdTable 00000001 
> >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
> >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> >>>
> >>> Parsing completed
> >>> Disassembly completed
> >>> ASL Output:    ssdt4.dsl - 8258 bytes
> >>> File appears to be binary: found 400 non-ASCII characters, 
> >>> disassembling Binary file appears to be a valid ACPI table, 
> >>> disassembling Input file ssdt5.dat, Length 0x480 (1152) bytes
> >>> ACPI: SSDT 0x0000000000000000 000480 (v01 LENOVO AmdTable 00000001 
> >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
> >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> >>>
> >>> Parsing completed
> >>> Disassembly completed
> >>> ASL Output:    ssdt5.dsl - 5582 bytes
> >>> File appears to be binary: found 1140 non-ASCII characters, 
> >>> disassembling Binary file appears to be a valid ACPI table, 
> >>> disassembling Input file ssdt6.dat, Length 0x1497 (5271) bytes
> >>> ACPI: SSDT 0x0000000000000000 001497 (v01 LENOVO AmdTable 00000001 
> >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
> >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> >>>
> >>> Parsing completed
> >>> Disassembly completed
> >>> ASL Output:    ssdt6.dsl - 20293 bytes File appears to be binary: 
> >>> found 1314 non-ASCII characters, disassembling Binary file appears to 
> >>> be a valid ACPI table, disassembling Input file ssdt7.dat, Length 
> >>> 0x1576 (5494) bytes
> >>> ACPI: SSDT 0x0000000000000000 001576 (v01 LENOVO AmdTable 00000001 
> >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
> >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> >>>
> >>> Parsing completed
> >>> Disassembly completed
> >>> ASL Output:    ssdt7.dsl - 30076 bytes File appears to be binary: 
> >>> found 4095 non-ASCII characters, disassembling Binary file appears to 
> >>> be a valid ACPI table, disassembling Input file ssdt8.dat, Length 
> >>> 0x353C (13628) bytes
> >>> ACPI: SSDT 0x0000000000000000 00353C (v01 LENOVO AmdTable 00000001 
> >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
> >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> >>>
> >>> Parsing completed
> >>> Disassembly completed
> >>> ASL Output:    ssdt8.dsl - 78242 bytes File appears to be binary: 
> >>> found 74 non-ASCII characters, disassembling Binary file appears to be 
> >>> a valid ACPI table, disassembling Input file ssdt9.dat, Length 0x90 
> >>> (144) bytes
> >>> ACPI: SSDT 0x0000000000000000 000090 (v01 LENOVO AmdTable 00000001 
> >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
> >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> >>>
> >>> Parsing completed
> >>> Disassembly completed
> >>> ASL Output:    ssdt9.dsl - 1767 bytes
> >>> File appears to be binary: found 32 non-ASCII characters, 
> >>> disassembling Binary file appears to be a valid ACPI table, 
> >>> disassembling Input file tpm2.dat, Length 0x38 (56) bytes
> >>> ACPI: TPM2 0x0000000000000000 000038 (v04 LENOVO CB-01    00000002 
> >>> LENO 00000001) Acpi Data Table [TPM2] decoded Formatted output:  
> >>> tpm2.dsl - 1515 bytes File appears to be binary: found 189 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file uefi.dat, Length 0x12A (298) bytes
> >>> ACPI: UEFI 0x0000000000000000 00012A (v01 LENOVO CB-01    00000001 
> >>> LENO 00000001) Acpi Data Table [UEFI] decoded Formatted output:  
> >>> uefi.dsl - 2505 bytes File appears to be binary: found 37100 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file vfct.dat, Length 0xD484 (54404) bytes
> >>> ACPI: VFCT 0x0000000000000000 00D484 (v01 LENOVO CB-01    00000001 
> >>> LENO 00000001) Unknown ACPI table signature [VFCT], decoding ACPI 
> >>> table header only Acpi Data Table [VFCT] decoded Formatted output:  
> >>> vfct.dsl - 269557 bytes File appears to be binary: found 17 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file wsmt.dat, Length 0x28 (40) bytes
> >>> ACPI: WSMT 0x0000000000000000 000028 (v01 LENOVO CB-01    00000000 
> >>> LENO 00000001) Acpi Data Table [WSMT] decoded Formatted output:  
> >>> wsmt.dsl - 1313 bytes Low Power S0 Idle is 0 The system does not 
> >>> support S0ix!
> >>>
> >>>
> >>> without
> >>>
> >>> Intel ACPI Component Architecture
> >>> ASL+ Optimizing Compiler/Disassembler version 20190509
> >>> Copyright (c) 2000 - 2019 Intel Corporation
> >>>
> >>> File appears to be binary: found 265 non-ASCII characters, 
> >>> disassembling Binary file appears to be a valid ACPI table, 
> >>> disassembling Input file apic.dat, Length 0x138 (312) bytes
> >>> ACPI: APIC 0x0000000000000000 000138 (v02 LENOVO CB-01    00000000 
> >>> LENO 00000001) Acpi Data Table [APIC] decoded Formatted output:  
> >>> apic.dsl - 16071 bytes File appears to be binary: found 40 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file batb.dat, Length 0x4A (74) bytes
> >>> ACPI: BATB 0x0000000000000000 00004A (v02 LENOVO CB-01    00000000 
> >>> LENO 00000001) Unknown ACPI table signature [BATB], decoding ACPI 
> >>> table header only Acpi Data Table [BATB] decoded Formatted output:  
> >>> batb.dsl - 1274 bytes File appears to be binary: found 31 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file bgrt.dat, Length 0x38 (56) bytes
> >>> ACPI: BGRT 0x0000000000000000 000038 (v01 LENOVO CB-01    00000002 
> >>> LENO 00000001) Acpi Data Table [BGRT] decoded Formatted output:  
> >>> bgrt.dsl - 1606 bytes File appears to be binary: found 16 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file cdit.dat, Length 0x29 (41) bytes
> >>> ACPI: CDIT 0x0000000000000000 000029 (v01 LENOVO CB-01    00000001 
> >>> LENO 00000001) Unknown ACPI table signature [CDIT], decoding ACPI 
> >>> table header only Acpi Data Table [CDIT] decoded Formatted output:  
> >>> cdit.dsl - 1115 bytes File appears to be binary: found 2765 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file crat.dat, Length 0xB80 (2944) bytes
> >>> ACPI: CRAT 0x0000000000000000 000B80 (v01 LENOVO CB-01    00000001 
> >>> LENO 00000001) Unknown ACPI table signature [CRAT], decoding ACPI 
> >>> table header only Acpi Data Table [CRAT] decoded Formatted output:  
> >>> crat.dsl - 15424 bytes File appears to be binary: found 15189 
> >>> non-ASCII characters, disassembling Binary file appears to be a valid 
> >>> ACPI table, disassembling Input file dsdt.dat, Length 0xAE9B (44699) 
> >>> bytes
> >>> ACPI: DSDT 0x0000000000000000 00AE9B (v01 LENOVO AMD      00001000 
> >>> INTL 20180313) Pass 1 parse of [DSDT] Pass 2 parse of [DSDT] Parsing 
> >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> >>>
> >>> Parsing completed
> >>> Disassembly completed
> >>> ASL Output:    dsdt.dsl - 384071 bytes File appears to be binary: 
> >>> found 229 non-ASCII characters, disassembling Binary file appears to 
> >>> be a valid ACPI table, disassembling Input file facp.dat, Length 0x10C 
> >>> (268) bytes
> >>> ACPI: FACP 0x0000000000000000 00010C (v05 LENOVO CB-01    00000003 
> >>> LENO 00000001) Acpi Data Table [FACP] decoded Formatted output:  
> >>> facp.dsl - 10098 bytes File appears to be binary: found 59 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file facs.dat, Length 0x40 (64) bytes
> >>> ACPI: FACS 0x0000000000000000 000040
> >>> Acpi Data Table [FACS] decoded
> >>> Formatted output:  facs.dsl - 1368 bytes File appears to be binary: 
> >>> found 28 non-ASCII characters, disassembling Binary file appears to be 
> >>> a valid ACPI table, disassembling Input file fpdt.dat, Length 0x34 
> >>> (52) bytes
> >>> ACPI: FPDT 0x0000000000000000 000034 (v01 LENOVO CB-01    00000002 
> >>> LENO 00000001) Acpi Data Table [FPDT] decoded Formatted output:  
> >>> fpdt.dsl - 1452 bytes File appears to be binary: found 30 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file hpet.dat, Length 0x38 (56) bytes
> >>> ACPI: HPET 0x0000000000000000 000038 (v01 LENOVO CB-01    00000001 
> >>> LENO 00000001) Acpi Data Table [HPET] decoded Formatted output:  
> >>> hpet.dsl - 1865 bytes File appears to be binary: found 279 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file ivrs.dat, Length 0x1A4 (420) bytes
> >>> ACPI: IVRS 0x0000000000000000 0001A4 (v02 LENOVO CB-01    00000001 
> >>> LENO 00000001) Acpi Data Table [IVRS] decoded Formatted output:  
> >>> ivrs.dsl - 6001 bytes File appears to be binary: found 36 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file mcfg.dat, Length 0x3C (60) bytes
> >>> ACPI: MCFG 0x0000000000000000 00003C (v01 LENOVO CB-01    00000001 
> >>> LENO 00000001) Acpi Data Table [MCFG] decoded Formatted output:  
> >>> mcfg.dsl - 1526 bytes File appears to be binary: found 32 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file msdm.dat, Length 0x55 (85) bytes
> >>> ACPI: MSDM 0x0000000000000000 000055 (v03 LENOVO CB-01    00000000 
> >>> LENO 00000001) Acpi Data Table [MSDM] decoded Formatted output:  
> >>> msdm.dsl - 1557 bytes File appears to be binary: found 25 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file sbst.dat, Length 0x30 (48) bytes
> >>> ACPI: SBST 0x0000000000000000 000030 (v01 LENOVO CB-01    00000001 
> >>> LENO 00000001) Acpi Data Table [SBST] decoded Formatted output:  
> >>> sbst.dsl - 1282 bytes File appears to be binary: found 410 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file ssdt10.dat, Length 0x47F (1151) bytes
> >>> ACPI: SSDT 0x0000000000000000 00047F (v01 LENOVO AmdTable 00000001 
> >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
> >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> >>>
> >>> Parsing completed
> >>> Disassembly completed
> >>> ASL Output:    ssdt10.dsl - 5673 bytes File appears to be binary: 
> >>> found 708 non-ASCII characters, disassembling Binary file appears to 
> >>> be a valid ACPI table, disassembling Input file ssdt11.dat, Length 
> >>> 0xC1D (3101) bytes
> >>> ACPI: SSDT 0x0000000000000000 000C1D (v01 LENOVO AmdTable 00000001 
> >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
> >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> >>>
> >>> Parsing completed
> >>> Disassembly completed
> >>> ASL Output:    ssdt11.dsl - 15424 bytes File appears to be binary: 
> >>> found 848 non-ASCII characters, disassembling Binary file appears to 
> >>> be a valid ACPI table, disassembling Input file ssdt12.dat, Length 
> >>> 0x9AD (2477) bytes
> >>> ACPI: SSDT 0x0000000000000000 0009AD (v01 LENOVO AmdTable 00000001 
> >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
> >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> >>>
> >>> Parsing completed
> >>> Disassembly completed
> >>> ASL Output:    ssdt12.dsl - 12474 bytes File appears to be binary: 
> >>> found 9207 non-ASCII characters, disassembling Binary file appears to 
> >>> be a valid ACPI table, disassembling Input file ssdt1.dat, Length 
> >>> 0x7216 (29206) bytes
> >>> ACPI: SSDT 0x0000000000000000 007216 (v02 LENOVO AmdTable 00000002 
> >>> MSFT 04000000) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
> >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> >>>
> >>> Parsing completed
> >>> Disassembly completed
> >>> ASL Output:    ssdt1.dsl - 208699 bytes File appears to be binary: 
> >>> found 3968 non-ASCII characters, disassembling Binary file appears to 
> >>> be a valid ACPI table, disassembling Input file ssdt2.dat, Length 
> >>> 0x1500 (5376) bytes
> >>> ACPI: SSDT 0x0000000000000000 001500 (v01 LENOVO AmdTable 00000001 AMD  
> >>> 00000001) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
> >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> >>>
> >>> Parsing completed
> >>> Disassembly completed
> >>> ASL Output:    ssdt2.dsl - 59265 bytes File appears to be binary: 
> >>> found 449 non-ASCII characters, disassembling Binary file appears to 
> >>> be a valid ACPI table, disassembling Input file ssdt3.dat, Length 
> >>> 0x53A (1338) bytes
> >>> ACPI: SSDT 0x0000000000000000 00053A (v01 LENOVO Tpm2Tabl 00009999 
> >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
> >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> >>>
> >>> Parsing completed
> >>> Disassembly completed
> >>> ASL Output:    ssdt3.dsl - 10738 bytes File appears to be binary: 
> >>> found 474 non-ASCII characters, disassembling Binary file appears to 
> >>> be a valid ACPI table, disassembling Input file ssdt4.dat, Length 
> >>> 0x64C (1612) bytes
> >>> ACPI: SSDT 0x0000000000000000 00064C (v01 LENOVO AmdTable 00000001 
> >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
> >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> >>>
> >>> Parsing completed
> >>> Disassembly completed
> >>> ASL Output:    ssdt4.dsl - 8258 bytes
> >>> File appears to be binary: found 400 non-ASCII characters, 
> >>> disassembling Binary file appears to be a valid ACPI table, 
> >>> disassembling Input file ssdt5.dat, Length 0x480 (1152) bytes
> >>> ACPI: SSDT 0x0000000000000000 000480 (v01 LENOVO AmdTable 00000001 
> >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
> >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> >>>
> >>> Parsing completed
> >>> Disassembly completed
> >>> ASL Output:    ssdt5.dsl - 5582 bytes
> >>> File appears to be binary: found 1140 non-ASCII characters, 
> >>> disassembling Binary file appears to be a valid ACPI table, 
> >>> disassembling Input file ssdt6.dat, Length 0x1497 (5271) bytes
> >>> ACPI: SSDT 0x0000000000000000 001497 (v01 LENOVO AmdTable 00000001 
> >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
> >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> >>>
> >>> Parsing completed
> >>> Disassembly completed
> >>> ASL Output:    ssdt6.dsl - 20293 bytes File appears to be binary: 
> >>> found 1314 non-ASCII characters, disassembling Binary file appears to 
> >>> be a valid ACPI table, disassembling Input file ssdt7.dat, Length 
> >>> 0x1576 (5494) bytes
> >>> ACPI: SSDT 0x0000000000000000 001576 (v01 LENOVO AmdTable 00000001 
> >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
> >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> >>>
> >>> Parsing completed
> >>> Disassembly completed
> >>> ASL Output:    ssdt7.dsl - 30076 bytes File appears to be binary: 
> >>> found 4095 non-ASCII characters, disassembling Binary file appears to 
> >>> be a valid ACPI table, disassembling Input file ssdt8.dat, Length 
> >>> 0x353C (13628) bytes
> >>> ACPI: SSDT 0x0000000000000000 00353C (v01 LENOVO AmdTable 00000001 
> >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
> >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> >>>
> >>> Parsing completed
> >>> Disassembly completed
> >>> ASL Output:    ssdt8.dsl - 78242 bytes File appears to be binary: 
> >>> found 74 non-ASCII characters, disassembling Binary file appears to be 
> >>> a valid ACPI table, disassembling Input file ssdt9.dat, Length 0x90 
> >>> (144) bytes
> >>> ACPI: SSDT 0x0000000000000000 000090 (v01 LENOVO AmdTable 00000001 
> >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing 
> >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> >>>
> >>> Parsing completed
> >>> Disassembly completed
> >>> ASL Output:    ssdt9.dsl - 1767 bytes
> >>> File appears to be binary: found 32 non-ASCII characters, 
> >>> disassembling Binary file appears to be a valid ACPI table, 
> >>> disassembling Input file tpm2.dat, Length 0x38 (56) bytes
> >>> ACPI: TPM2 0x0000000000000000 000038 (v04 LENOVO CB-01    00000002 
> >>> LENO 00000001) Acpi Data Table [TPM2] decoded Formatted output:  
> >>> tpm2.dsl - 1515 bytes File appears to be binary: found 189 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file uefi.dat, Length 0x12A (298) bytes
> >>> ACPI: UEFI 0x0000000000000000 00012A (v01 LENOVO CB-01    00000001 
> >>> LENO 00000001) Acpi Data Table [UEFI] decoded Formatted output:  
> >>> uefi.dsl - 2505 bytes File appears to be binary: found 37100 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file vfct.dat, Length 0xD484 (54404) bytes
> >>> ACPI: VFCT 0x0000000000000000 00D484 (v01 LENOVO CB-01    00000001 
> >>> LENO 00000001) Unknown ACPI table signature [VFCT], decoding ACPI 
> >>> table header only Acpi Data Table [VFCT] decoded Formatted output:  
> >>> vfct.dsl - 269557 bytes File appears to be binary: found 17 non-ASCII 
> >>> characters, disassembling Binary file appears to be a valid ACPI 
> >>> table, disassembling Input file wsmt.dat, Length 0x28 (40) bytes
> >>> ACPI: WSMT 0x0000000000000000 000028 (v01 LENOVO CB-01    00000000 
> >>> LENO 00000001) Acpi Data Table [WSMT] decoded Formatted output:  
> >>> wsmt.dsl - 1313 bytes Low Power S0 Idle is 0 The system does not 
> >>> support S0ix!
> >>>
> >>>
> >>> #################################################
> >>> #!/bin/bash
> >>>
> >>> cd /var/tmp/
> >>>
> >>> acpidump -b
> >>>
> >>> iasl -d *.dat
> >>>
> >>> lp=$(grep "Low Power S0 Idle" /var/tmp/facp.dsl | awk '{print $(NF)}')
> >>>
> >>> if [ "$lp" -eq 1 ]; then
> >>>
> >>> echo "Low Power S0 Idle is" $lp
> >>>
> >>> echo "The system supports S0ix!"
> >>>
> >>> else
> >>>
> >>> echo "Low Power S0 Idle is" $lp
> >>>
> >>> echo "The system does not support S0ix!"
> >>>
> >>> fi
> >>>
> >>>  
> >>>
> >>> Thanks,
> >>>
> >>> Basavaraj
> >>>
> >>>
> >>>
> >>>
> >>> --
> >>> Stephen MacNeil
> >>> 905 334 5092
> >>> mglessons.com 
> >>> <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fmglessons.com%2F&amp;data=04%7C01%7Cray.huang%40amd.com%7C0dbf347b744f4480a76608d955aab43c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637635013945224005%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Zc6RqCBpmncIWTGiBpZ%2BmOBmPVV7gIx8mS2hqBenP6k%3D&amp;reserved=0>
> > 
> 
