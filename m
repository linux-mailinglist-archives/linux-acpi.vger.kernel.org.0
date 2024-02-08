Return-Path: <linux-acpi+bounces-3301-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A29984E6FA
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Feb 2024 18:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4320291A95
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Feb 2024 17:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D03823CF;
	Thu,  8 Feb 2024 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z4ZnMK6t"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E8D823BD;
	Thu,  8 Feb 2024 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414209; cv=fail; b=TEQWAxEu3ZV4GkcKUzKPJMHyDs3q4ic0atfJU6Ase8hCzIIsWNRWi6mbsE3zm2w5JRVm+HGKJ7mHsqJRjhaG0in0vquyen063NqWOOqfpht+dE6D+BZpQbsooWygRtuK+mTtxtumbY/NV1DhWGoq3VaJwvl/RlbrfPiZGlpcLxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414209; c=relaxed/simple;
	bh=bIJe48KmoXOpRH/GJDsQYhYP95A/pB75tO3Kx/HcaHg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V4MluV0+4jQt0VcFp680JCcPOAsUqkegp0/FceCuVzB3Em8XrwcRnZQV091F7TKTTqT9Y8jiZWg0gEZllPSEI0Zdqj/h5f76hsXRFDfpsqDpn/RXR45esyX9UvZ3wD2nYskwgcaWottM15nmhNjrNDdH9seG4ukSuhX4h7udkGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z4ZnMK6t; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fnd2s4vY5zaLdcGtuxRf27W3yH3Uec6XCZ3/zmnZGaD1bA4qSBtRhQP9PgdmX/2UT9A8O5f05gQdGORBtt4fiwGyuqun+jl7sizVqtsCiIeHC4i8xxvMelXN97tqRd7x8U77sFxH6SYXnbXnAqPS3xxv2PYAgo2XnOQwiS7pDFMaAHZw0hhV4xDGirrKWAmapAj5XTqxVGQt51cj4MhlWZOXkwTuBxefgB6UAHzDweR3+YavZ0iIeBcQLbMt6pEQCpNkCSfFFst4F1KFDsRDInrXdowg0HrGkK8tDmBApTk+bC+293RHUZW0DQXvYcbyY4Q4zuAAqsojCQLOYUrBbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RWFgItA9mhHcsHtCzzCu/AzFUt4rE/+JKN1n1Q9Z18=;
 b=RUNJp4PH6sxG0Aq9UYgA8KsV0jhRtPMGTvTkNxHLERR0SsijFkDlS9ufhJ2Rj2/CVUrOS0W7LkQm7TbIfFKG6pVwPhSt+VhzRFHi/Le0iyCIdwyOL38OthOUYcG8jNfYK0SeEb4aBpA8YYrslQIvbPCfovHMM7anmz3eUqIxC8aNTf7SHBnoHPWjcGCJVd7ESqIZGPa9uD+uPsAEvMCiK5Lsx2iW8XA/mX3Ktbq3wR0TlcQnFwzkQ6kYdRR7OWa8gkJyyVS/QiHa6Mub2tlC6Q400je6MC1RwtC9QDtGsb1xGxAmMExbI+p7Mrv97gu2n67luF+ShHlxag9WhDXeEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RWFgItA9mhHcsHtCzzCu/AzFUt4rE/+JKN1n1Q9Z18=;
 b=Z4ZnMK6tU/k0/w6ex6LVHPgMNPNutNdbT9EeoZSSYM2GMg7wJw/EIQjPFHc8/AesvbZ3yIGjLPP2XoHHhMIBxMtAd/SKcWOKtgzAoq2dAHBuJ3UiVXUxGr8lAcLSSp8t41ZNnqGhX2x4mSEguSR6CxJBNqqqey8Z+4dVu2X/LNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by MN0PR12MB6270.namprd12.prod.outlook.com (2603:10b6:208:3c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Thu, 8 Feb
 2024 17:43:25 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::b21f:aced:8bae:a73d]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::b21f:aced:8bae:a73d%7]) with mapi id 15.20.7270.015; Thu, 8 Feb 2024
 17:43:25 +0000
Message-ID: <5b3adc24-00d4-4e8e-b870-01cb7cfb5efd@amd.com>
Date: Thu, 8 Feb 2024 11:43:19 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/5] ACPI: Add CXL protocol error defines
To: Dan Williams <dan.j.williams@intel.com>, dave@stogolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 rafael@kernel.org
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20240117194501.298233-1-Benjamin.Cheatham@amd.com>
 <20240117194501.298233-3-Benjamin.Cheatham@amd.com>
 <65bdb9f8920f7_719322944@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <65bdb9f8920f7_719322944@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR15CA0005.namprd15.prod.outlook.com
 (2603:10b6:408:c0::18) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|MN0PR12MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c32413-7a59-4e42-c6e4-08dc28cd7379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	77MmZY+TJ+ay+wAxvy+Ss7/XfLLVr7Km/9pgWoJbD2p4UqdH97cZV24rwcuVCo1KoK3BIo6BcIbUyYFLWWEvbATXqN3nYRXTyY/pz8x/zsYk4ZFTuwCahcmKUZY0J62aDs6Ua2NcNAZ+VSNzeOILOjqY1eZQnSmZMnjOq4gb8TkRvAffT5wvYUCHSSHifepkThWjGVgEWXVASrvoW1xUcMiOxzRc3t4G/YLChyrgm4BxYZ/sIRckiZHwpq4M9t+quLcWOKU/5hy60htJZIBR1EnU9RM3dJVlkSMpeNv+HlRBAchHinixac3uqfnbpAKmGobbtsRnTSnz9TYNkohyEMsuPJhufgejJqXSCpaHX/JbxHNvdRjHcAcYgfEExmk+062ecwBYzQ/CgHZ1nqogxycKdyHiYFca0awB4Dm3Nns9p3B1miM+u04hyQZImeF5ICSxDRPvAKAFPskZrxy2uYJMPiVDNFql/B2Adpqik5Jgu5HIKldixpNivSULh2AO2tBlppqYR4odtzqwp95ZX7SIRxxj4Z8TahI4De6fSPLzYBs85zdyW8ayHeCdkKGk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(41300700001)(6486002)(86362001)(31696002)(6512007)(36756003)(26005)(66946007)(53546011)(2616005)(66556008)(478600001)(8936002)(5660300002)(6506007)(316002)(6666004)(4326008)(2906002)(8676002)(83380400001)(7416002)(38100700002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czNBOGpCZFZVNXNmUTgraUtYaE04OS9FczRhU0t1TGMrRVppL1dqaVZMZm94?=
 =?utf-8?B?cmFWaWYzWk14U1NCSU14TmdhWjBnVzRCMFhwWi9qTEdabzBuWi9RcHdLUlJs?=
 =?utf-8?B?WGdNamI2UXVIZkYvUGtuVjVHVW5KZ0Fvelh6eTVLVWhRNjZDZ0F0RXFzMzFG?=
 =?utf-8?B?NytES0ZCQm1SQVYxY1pNVVJvNTVrWmNsaUdvNThpTVlMNHJ1d1Z0Rjh1NUdP?=
 =?utf-8?B?bDNzZHYvcGRGN3VOQnVyVUQxV3FMdXBKcGp6LzFjOVFpL1F1dC9NU2RVOUNx?=
 =?utf-8?B?OHp3WGpTWTZWM1JGZDVNYkNqUmJlUFgrRzJpbWhDTFZsNm80b1FIVUZ1RkY3?=
 =?utf-8?B?dmV2Q1pOUXliY1J0bWZ2Vy9wUHFUR1VaQlBXTTlZcHpMOHdkclVIb0d5R0xp?=
 =?utf-8?B?dEFOUFhHOWVQMmVKQytOZjJwNmkwNUIycVVBVTNCQ2FLeXlPcWpCeDlMU0th?=
 =?utf-8?B?VWVSS2N1TTMyRWpJLzNkUmpPWC9pVzRmWXd6VnpkMVFBSHZBejF0NHpmeUlK?=
 =?utf-8?B?OVRFZU11akNIN0dmYml1eUhzZ2hGNWNCb1RCRDRINUZBeE5odGJiOWJjTFYx?=
 =?utf-8?B?MXlnZHF2cHBEV08wQ2h5OEdqa1ZwUS9wbmNRUDBCTkt1TWdZNGQrdFo2VmRn?=
 =?utf-8?B?UFRxcElKZFVyWUtRbnFhM04wTnQ5a3RvQ21BM1RlNWpKMlpOem14dnBKbTFP?=
 =?utf-8?B?cnk3YjVIRTV5UmZWaUNTM1g3NnRCa1hlUWJYYUE2dW9wKzQ3SmFTcndaUWlN?=
 =?utf-8?B?amRUY1d2Tk5zcXhqZ2lISWNua2tzTWo1Y3NsU3NlRHM4NERCTjdpUFpOZVYx?=
 =?utf-8?B?Z0x5Nk5kci9pQ1FxTGdRa2xpUEVGY254RFpiL1N6cnByNTNVZHdyLzBtcVdD?=
 =?utf-8?B?ZHRPZ0hJdnBlcVZtcGtEUFdPUW83Y3NVbm9SLzcvL083T0xGMytObEZIYTZa?=
 =?utf-8?B?UHFwTGllM2dzaVlJekg3SW1WaTl3aUZRc2Yvajk1MWxlY0FYK2RRUHJZTzZo?=
 =?utf-8?B?WUl3RnFJYm5GNktoaDNtcit1VEMxQXRETkdianF0Nzc0dVk5T256aDNsU2ZI?=
 =?utf-8?B?d01PVmM1U1NIelRkTG11bkpOQjAzWTNsYTVnNDZ2dkF6a2ZJZ0dHc0ZpMmR5?=
 =?utf-8?B?Q2dKZzVTenJ2a2J6OFcrRzNjZEYxZXYvaGFVeW9LTUpKSkUzRGw0R01reXlB?=
 =?utf-8?B?UWcySmlCK0dQM1kxMnBjNVVvMnpJQWxyWVArN0EwUWxubmg1elE4Nlh2Zm9r?=
 =?utf-8?B?UDBSTnVsS0JRemxHV3A3YkVLNk5hZytUSGo2VVlhRDhGbFd4M1M4dlZzZWZL?=
 =?utf-8?B?dXBJSDRPRGttMmlvdWgvSUF4UjB5Ty9BU0dEeVh2UG5wNUE3VzRHRFBVZEZP?=
 =?utf-8?B?N1JwdWVEVFNNb1dkR1d4T0JkWG5meVo4aWFIc0dRbFlLaUNtSDZwdUdWN3Nk?=
 =?utf-8?B?Um1GVDNsamdXcDZ5SmwvSExhQTZUV3dGZ0FrcFBpeVRHWGJVTmpEZUtFcWNU?=
 =?utf-8?B?ZmR4SzhhbkFMZ1RjT245djBZcktYNUdwWHZzNnFGNTV4KzBMR1gxRnF2QXVq?=
 =?utf-8?B?RW4yV2hJSjhpZWFiQUN5S1FnN3NYWXpSY0wvdzhrV2NvNDBUTXRRRkRMVjhi?=
 =?utf-8?B?N0h1WkM0bWpTNnltN3J5dFBpNUVibTRWWmdVVzY3RFBUOWprY1lGL0IzRTB4?=
 =?utf-8?B?NWFsdUhMcmw0NnJKUXUydXA1OWNSZ3M0Y0lYcXRDdm5pVC9QUmFHN0xjenFw?=
 =?utf-8?B?SDFZajNUQ3Z5SG1IUWRWL1RvNWlZd3R1ekRqN2dXWTE5c0lFYWU2eWZZWk5q?=
 =?utf-8?B?UXlYZE1BSlU5WTRxVmxEZnFRaVZ4akMxU3lRZkxIZDFzWFR5U3RBcDcyTU1h?=
 =?utf-8?B?RCtLSE5xWURlNkZsRVpUSW1QeThxcXZSbzVDSmZpdit0TmNsOGwwUHpnVUNk?=
 =?utf-8?B?Q3UvcSs1ZEQ4bC9RbjZZZVVVdm9wM28rUmw5SGtuQXJGSE5DUTJHWjN3cmd3?=
 =?utf-8?B?MkFGUVRJVUR5U3I4V29JZTVMRlhXa0lvcXZnckI3N3Mxb24vNjAyZm9GOTVs?=
 =?utf-8?B?MGVpVGhlZm5lZkROS204aDF0RlZmTEZ1YWFuSXp3L1p2TUJKbUdneENhbnNx?=
 =?utf-8?Q?IoIsTvRcjJSvhPQVMB7OpsqHV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c32413-7a59-4e42-c6e4-08dc28cd7379
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 17:43:25.2525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llBI01A86m5nbyx9RR5mQeOpiVaHDhsnKzkjbf9IvUQN6dAsD4+Cj1ve8lSkdSodmtbLlBzV/H7C+CswRxZXng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6270



On 2/2/24 9:58 PM, Dan Williams wrote:
> Ben Cheatham wrote:
>> Add CXL protocol error defines to include/actbl1.h.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> ---
>>
>> I made a pull request for this support in the ACPICA project which has
> 
> Hmm, it has been a few months with no movement and nothing in v6.8.
> 
>> been accepted (link below), so this patch is temporary and I expect it
>> to be dropped once the kernel updates from ACPICA.
> 
> Ben, not sure what is happening with the ACPICA process right now, but
> since the ACPI_EINJ driver is the only consumer of these defines I would
> say that in the spirit of the policy in "include/linux/pci_ids.h":
> 
> "Do not add new entries to this file unless the definitions
>  are shared between multiple drivers."
> 
> ...go ahead and defines these locally in einj.c.
> 
> #ifndef ACPI_EINJ_CXL_CACHE_CORRECTABLE
> #define ACPI_EINJ_CXL_CACHE_CORRECTABLE     (1<<12)
> #define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   (1<<13)
> #define ACPI_EINJ_CXL_CACHE_FATAL           (1<<14)
> #define ACPI_EINJ_CXL_MEM_CORRECTABLE       (1<<15)
> #define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     (1<<16)
> #define ACPI_EINJ_CXL_MEM_FATAL             (1<<17)
> #endif
> 
> Then you can delete them later if they ever get duplicated in actbl1.h.

Sorry for the late response, but will do! I should be able to send a v11 this afternoon
with this change.

Thanks,
Ben

