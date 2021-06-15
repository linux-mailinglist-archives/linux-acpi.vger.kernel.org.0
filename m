Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC65E3A73D7
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jun 2021 04:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhFOC04 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Jun 2021 22:26:56 -0400
Received: from mail-dm6nam12on2083.outbound.protection.outlook.com ([40.107.243.83]:32705
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230344AbhFOC0z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 14 Jun 2021 22:26:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkhb+7H5NM8Tzh5spzafCop4TMljWatHAOgEeOu3w8SF7f/uk9VwaNSghN6/K1bj3cai4P/KCf4Rn1vgYNRQhXGyPpaGLUm5lOo9sjgABaX5K7VQlg3HoPsIRJIn9PnuXguFPy6oA12Qp5uFWQ/+nZ/ryYk6xKhkG1IH598g4jPELFo0QtEBVIkihMsG4SkBp1CEwAzzet16M0UhRHCwsEIG7sSK7d3f7W9KVhvY4NClewuN8dWmrvuO/UdeMq04FFTulKwjxYaUFVtMtdvgwyCkepqVMYZGDgSjEOzMP1w9wl3Hl3aI7Qk678JwW4CQ88woV03rNjUU9hfEpSPG7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vYwWKrHaoCMvwl/Ll1hhcr+itzrmxHeRuPJTW+zACQ=;
 b=WupCJvNpB8LHpl3Q9Ycbm0Ui0veZq5grC8UDQHhMXvKbraSlb+/O/NNpAqJ8+u4H5GxyKTqv1CAj9K7ztiGuh10v5Tc9jIQ/WV4NgbBpyt/ea0ztPTXk+23Kk9pF0aeDtW8pO9vKZ0i+c7g+D6m0CPZaE33QE3CY4pF//JMFE095bVuEoVQ7oAL0qNrU5pKGABCZfXLqtpW2Xm0wKk4by0OUNgToQPPOyxlurz3WA/tC5x55/Ik5P4+0bZWesjqSqZBDyUhZrc8kVK3jBCIKC5JC+W0MDYJyk6Xpc3pMTvP4b+/HkWOcHHMDhy9LmGvTvWh5MCdRMpMD8NrSaLDHeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vYwWKrHaoCMvwl/Ll1hhcr+itzrmxHeRuPJTW+zACQ=;
 b=GjVx8TZEv2vf6C9zqzpJmtZ7oT77v7rIIhvA1Aad+2p2GdIwnJLm85/igLc8qd/G/tw5MI7Qc9t7SaIk3V1bMsEQIl/sKPTua22RZuAFLUsIsUjWjgMYiLbWFffQB9IEwr7fQeH5aOW6Zj1S0iPoBWNI694kV2f9ct/UNFcUT8U=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SA0PR12MB4511.namprd12.prod.outlook.com (2603:10b6:806:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Tue, 15 Jun
 2021 02:02:39 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9c16:2794:cd04:2be0]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9c16:2794:cd04:2be0%5]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 02:02:39 +0000
Subject: Re: [PATCH v8 2/2] ACPI: Add quirks for AMD Renoir/Lucienne CPUs to
 force the D3 hint
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-acpi@vger.kernel.org, rrangel@chromium.org,
        david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, Alexander.Deucher@amd.com,
        prike.liang@amd.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Julian Sikorski <belegdol@gmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20210609184018.26017-1-mario.limonciello@amd.com>
 <20210609184018.26017-2-mario.limonciello@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Message-ID: <831df669-b38e-9f4b-dd67-b613aaab6c28@amd.com>
Date:   Mon, 14 Jun 2021 21:02:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210609184018.26017-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SN2PR01CA0005.prod.exchangelabs.com (2603:10b6:804:2::15)
 To SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.254.51.208] (165.204.77.11) by SN2PR01CA0005.prod.exchangelabs.com (2603:10b6:804:2::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Tue, 15 Jun 2021 02:02:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 281b6395-5272-4afe-c328-08d92fa1a6f3
X-MS-TrafficTypeDiagnostic: SA0PR12MB4511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4511C0EF12122977A358EDFBE2309@SA0PR12MB4511.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: upZr9cYYPlRhqVqDoPn/9uWFn5hbyAxsF8drK7KyNfSoJj5HwK9j/hioKTxWiTnDN/cLmYgDaNeCSj6TNITSDI0E3bF7AEl382W0wrLYrWCeBIE3OsC6mNt7eVzGf6QXoVGxM68Z+Y+x12vpqTcg6cAGPkWIbjxZ3RFhTTd+cQ6VbuQVFMXyuRYh7rIpR7XiykMDOcg1H+FDiwu9CV6N/3rBVM6snRA7qfvWbSSZHrMsHHwzhAyw3ilyQ6I9cEPdl1MlrgiDEjSoStLx6GjiOR6i0spL4gescA4PtrCq7YmRmIkJLgk/Rlw8avVvkkkhKJxKWEUIWA3VSaIrYlG+Zwp/Gdbfet76aG1/IOOVuAOjG5NLHqUxAsZuPfmLPR9i56d89rQI1BC+DCItmqSfpRlM6Q3dkGrkFekRzSALpcq+MFpfQi1povcIlUXMXL80JzSho8qUwVpSCg1Ssqm6NnxVnOyT4jLHrBbyEkh13RR3bBVgmTFkl15KVxhrGX+JdCNWt6Fx7JvXShiiniBoLjJGsW7cB8Q6qggfPz4osAXrttyM/rzTSplGEWns0I3IOEQ3OXkbJMtYVOZX/yasLlCRgk39ieOuQPyhgqUICnCKP8AdgyLAkq0lRf3V8mR2QibvbKkUQ5QGUsoR3p2Mvr6L8JtIJU3nOtHamvpysrfj9m4j4dIMe+QCa6iu6aD9rXmmutttvDw6IoSCbbrCvaXX39oY3Ck44zzSdiFEjBIiUCwHnRIsGFq6AvbRzDmWIWfNvJje8xGrKHvLoNxmQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(7416002)(8936002)(31686004)(966005)(38100700002)(86362001)(8676002)(956004)(2616005)(26005)(16576012)(54906003)(2906002)(36756003)(6486002)(31696002)(478600001)(4326008)(186003)(16526019)(110136005)(66476007)(83380400001)(66556008)(53546011)(66946007)(5660300002)(316002)(45080400002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnpRNnlUKzJxMVV5NTBpZVdZNThiaGtPYXNIMk1mWjVIbWlza0Q4ZFRpbHRk?=
 =?utf-8?B?V0c0bU15cmRmSTRDdk1LTHc1UTBkLysrWWRFZzBSRmo1d2ZPTW0rc3dYVEVv?=
 =?utf-8?B?S1ZYc2lFWkJ6N2JnTXlQR1o5dHFHOWZ6SFFHTkNUSW9jWEtDOXYrbkFWZ244?=
 =?utf-8?B?Nm1acWY3ekVGY0tyT2hWMU8zNENnREg4WkNjOFoxQmRjM0NEaktIMUdaTzVZ?=
 =?utf-8?B?Y1l1Yks5S25NNmhIZVJUTzJ2TGpMUVA2cHZpb2pBVnM3RlhQd3VIT1kwRWhi?=
 =?utf-8?B?bStFcUZvZ3NRV1IvM1BKd1VOc0RVK2NnSmpPSjhTeHdTV3AzQVNxb0p3VllO?=
 =?utf-8?B?c1dCYndkMUhDUTc3UFJ0NDZFYXFuZ1dDcThJREdrWHNnRkQyeTNQdlpmMGgv?=
 =?utf-8?B?MFFvVEZBR3JadjNQSzZGV25tYmc5WmhtRzEyRi92VDhTRDZ1NWNPKzZSRWU1?=
 =?utf-8?B?eUdyTjlyOExQa0F6bDZWLzIrMkhmclVXU0dzU05yT05qc3BkdGZRSWZDUTd3?=
 =?utf-8?B?VG1WOVZFR0RKVGZ1UEJRVW5YUnN3ZUlQSkJxNG55SGJQNEZJSXluYzh5WTFR?=
 =?utf-8?B?cCtOcEJoQUR3SmZIZTh2RnYvTEtoYlhlVkcxcnQ2NzJ5djlBeU1TSS9GK1lE?=
 =?utf-8?B?U01ZeVpGaGZkMnYzNVlWS3hXSGpuYjFUTDFpdk5qcXNlTGxkd3ZzWlR2RVZs?=
 =?utf-8?B?WWNBTmlKSzhpY3c5OEE3ejlxTy9CdFV4QTB5R2FVZlBQWmpqMDRLTjQvVVpF?=
 =?utf-8?B?WVIyZHdnbXd0VEtZa2pZdE9FNi9rMVVFUzRySEJzTFFXL21Sd0xsbENrc0hG?=
 =?utf-8?B?VXBFZkdVQVptSjFpRWZHUmcrb21IKzltRnBDL0pVZE14Y2toYUpzcWN2Z3dE?=
 =?utf-8?B?OEhpR3VqOGhYZlNFU2lwUUdLclQ4MjVQQmJmVmYyc0dFanRDcmNzTU1rNnF6?=
 =?utf-8?B?NmlBMzFXTHZvNFVvVmIzUDZ6eVVjNlVTd0xGU3I1b3ZDYjdWL2pVTkd4VjlG?=
 =?utf-8?B?cEcxSThiN05xR0Fwc0lBTzlWSnhWQndJVy84ekxDOC9zblNsczJCWVljL1E3?=
 =?utf-8?B?V0V0Q3pPM3hCTXE4YWY5Ky90TS9CVkc5aEFSTmJpMnBnQ3M4VnAyRUlud0xB?=
 =?utf-8?B?RlNpUnowclZVYlI2VWlOUllUM3ptVlROS2dyTDM2OEw0cXlEcEp0bnZYV2Vy?=
 =?utf-8?B?dk5PTEIycXlybmVIVFd5WE5STnVTcWYydW5NWXIvR0JCMFpwVkFuVzBhdWFC?=
 =?utf-8?B?NmtVNFAreVIxQ25WbVZheHFnNWNkRmFGNEIvSFN0dzVNOHROL0ZSNDFZNzFq?=
 =?utf-8?B?RG95ZWtYYWtmQWx6czhQZ3d2dGdHUG9NR3FqSDRsY3ZRZHFsRFpVeTJMSmdi?=
 =?utf-8?B?WmFFRitvelRGU3c1bDd0d0lDUlUyOUhiM2lnektrSW5XUkgxek1SMVV2cU81?=
 =?utf-8?B?eGV2a3hRZWEvUHdmeldhdE95NVRNV0YwSnBEd0kwbmtjdFRjcGNyeG9jQkNm?=
 =?utf-8?B?eDd1V2ZVdzJUU0p5aEw0TG41ZVFFcFpRQWhRUGF1Zk10RlFRYmtLb0p5YVNo?=
 =?utf-8?B?UFI2RjB2TVovQTJ1LzRoN0ovdDdGVG1hSy84RjdRSzhObitrOVphMEpSZndD?=
 =?utf-8?B?enNZZGFFVlViZ1gxWXpMWGxBQU10WDBMRnNGT2U2MjZiL2pMT0tUTmVRMlBq?=
 =?utf-8?B?QTNUbERkNmNDV29WUzdBQ0JCVWZGTjgzYU5rV2s5bkNpYnY4Y3ozaFZQaUxV?=
 =?utf-8?Q?7wZoBLmIgr9g3b2QCx8vGcUzcKMlXOoIqwfbzzc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281b6395-5272-4afe-c328-08d92fa1a6f3
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 02:02:38.8999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pn4ZaWSCRXex5kSwQZY0pjabYohe4NGbashyztEF+cgb1lnnNvAVC+W/CGOCxAukmZcqrQK56NdjGPGe+4dSzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4511
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 6/9/2021 13:40, Mario Limonciello wrote:
> AMD systems from Renoir and Lucienne require that the NVME controller
> is put into D3 over a Modern Standby / suspend-to-idle
> cycle.  This is "typically" accomplished using the `StorageD3Enable`
> property in the _DSD, but this property was introduced after many
> of these systems launched and most OEM systems don't have it in
> their BIOS.
> 
> On AMD Renoir without these drives going into D3 over suspend-to-idle
> the resume will fail with the NVME controller being reset and a trace
> like this in the kernel logs:
> ```
> [   83.556118] nvme nvme0: I/O 161 QID 2 timeout, aborting
> [   83.556178] nvme nvme0: I/O 162 QID 2 timeout, aborting
> [   83.556187] nvme nvme0: I/O 163 QID 2 timeout, aborting
> [   83.556196] nvme nvme0: I/O 164 QID 2 timeout, aborting
> [   95.332114] nvme nvme0: I/O 25 QID 0 timeout, reset controller
> [   95.332843] nvme nvme0: Abort status: 0x371
> [   95.332852] nvme nvme0: Abort status: 0x371
> [   95.332856] nvme nvme0: Abort status: 0x371
> [   95.332859] nvme nvme0: Abort status: 0x371
> [   95.332909] PM: dpm_run_callback(): pci_pm_resume+0x0/0xe0 returns -16
> [   95.332936] nvme 0000:03:00.0: PM: failed to resume async: error -16
> ```
> 
> The Microsoft documentation for StorageD3Enable mentioned that Windows has
> a hardcoded allowlist for D3 support, which was used for these platforms.
> Introduce quirks to hardcode them for Linux as well.
> 
> As this property is now "standardized", OEM systems using AMD Cezanne and
> newer APU's have adopted this property, and quirks like this should not be
> necessary.
> 
> CC: Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
> CC: Alexander Deucher <Alexander.Deucher@amd.com>
> CC: Prike Liang <prike.liang@amd.com>
> Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Tested-by: Julian Sikorski <belegdol@gmail.com>
> ---
>   drivers/acpi/device_pm.c |  3 +++
>   drivers/acpi/internal.h  |  9 +++++++++
>   drivers/acpi/x86/utils.c | 25 +++++++++++++++++++++++++
>   3 files changed, 37 insertions(+)
>   
> Changes from v4->v5:
>   * Add this patch back in as it's been made apparent that the
>     system needs to be hardcoded for these.
>     Changes:
>     - Drop Cezanne - it's now covered by StorageD3Enable
>     - Rebase ontop of acpi_storage_d3 outside of NVME
> Changes from v5->v6:
>   * Move the quirk check into drivers/acpi/x86/ as suggested by
>     Rafael.
> Changes from v6->v7:
>   * Move header location
>   * Optimization of force function
> Changes from v7->v8:
>   * Add tags
> 
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index c8600978b283..c40fc135ff0c 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -1360,6 +1360,9 @@ bool acpi_storage_d3(struct device *dev)
>   	struct acpi_device *adev = ACPI_COMPANION(dev);
>   	u8 val;
>   
> +	if (force_storage_d3())
> +		return true;
> +
>   	if (!adev)
>   		return false;
>   	if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index f973bbe90e5e..e29ec463bb07 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -236,6 +236,15 @@ static inline int suspend_nvs_save(void) { return 0; }
>   static inline void suspend_nvs_restore(void) {}
>   #endif
>   
> +#ifdef CONFIG_X86
> +bool force_storage_d3(void);
> +#else
> +static inline bool force_storage_d3(void)
> +{
> +	return false;
> +}
> +#endif
> +
>   /*--------------------------------------------------------------------------
>   				Device properties
>     -------------------------------------------------------------------------- */
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index bdc1ba00aee9..5298bb4d81fe 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -135,3 +135,28 @@ bool acpi_device_always_present(struct acpi_device *adev)
>   
>   	return ret;
>   }
> +
> +/*
> + * AMD systems from Renoir and Lucienne *require* that the NVME controller
> + * is put into D3 over a Modern Standby / suspend-to-idle cycle.
> + *
> + * This is "typically" accomplished using the `StorageD3Enable`
> + * property in the _DSD that is checked via the `acpi_storage_d3` function
> + * but this property was introduced after many of these systems launched
> + * and most OEM systems don't have it in their BIOS.
> + *
> + * The Microsoft documentation for StorageD3Enable mentioned that Windows has
> + * a hardcoded allowlist for D3 support, which was used for these platforms.
> + *
> + * This allows quirking on Linux in a similar fashion.
> + */
> +const struct x86_cpu_id storage_d3_cpu_ids[] = {
> +	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),	/* Renoir */
> +	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL),	/* Lucienne */
> +	{}
> +};
> +
> +bool force_storage_d3(void)
> +{
> +	return x86_match_cpu(storage_d3_cpu_ids);
> +}
> 

Christoph, Keith ping on this series.  Any other thoughts?
If it's good can you take this in for nvme-5.14 since Rafael mentioned
the conflict from the other StorageD3Enable commit in nvme-5.14?

