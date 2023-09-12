Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9449D79D402
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 16:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbjILOtL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Sep 2023 10:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjILOtL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Sep 2023 10:49:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2F1115;
        Tue, 12 Sep 2023 07:49:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fO0p0Jx2p6Vd0VMqFDnW6YoELUcCcGcDJvuQun3U56QIrs5+k2Smpqwpaz01bJaASy0H9QeoMTFo7sHWCKUvMluYlPiZ+jdPVd4ULtF/gTMxyR2IL7jbdSIgIQ31gpESOZmZOObKy/USdkKgSs2C3GeBWczgyTt6U0rhVbF18OtSI8YVbup76In/GKXxHD2nVdz0hsUSKNqlNxaItHHjgzM9tvhgbeWtIzq5/XxTSTT9RGN62ZN2O84/RYbAX0Sx9jqjyTWNaHDFbKuqlbPWEKVEh/p0oZtoXxHSMukqNz6VllY2jdLkmbC7ztGmY7WCwacSjZOpjZmYHSQEHkiSeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXsurT0rhmu19B1Kg6kSEtrn40/dAf/as/jhiM8CKMI=;
 b=I+N/FbaXd7i4rOyk+alKENfcB2PdNfJbm4Cbz+YvJGKsMPcYsBXnqQpoGJHqdhI7MRDDPzogpoTEg7xmUX2jb656MzfF7GkwmgGr5rZqbxFCOLiayFjz3L9BUFyKKlB9TPF26bBrEJKzYIGFIXHnNtsnj6mDVtpC6w+ze0Sq+V6Sx5z2GKv94F5NSiYaCj3dC8gUWmK3KG1Clhhy27Pu9P3iy+ZLji9jS40QXAlwubDzq0RAtJNdp3Y4+Ahl4KKKfqnxUDUWyl2Ja6PGqFc+u72uUe++eTQtIYTaZM4rm0C6QKgBwb48M8zTCvoIJEdKAwS+oCbMdPZaquIMEFPrYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXsurT0rhmu19B1Kg6kSEtrn40/dAf/as/jhiM8CKMI=;
 b=gn8EiHbFf/05OZmnIBTyxbyweo2hJzoN42/yK+93LhmqhXyd7tq+XIAaQfmwHN5PM41h+70TG+k8vQqr5m0oJ0aCRyu6XvQGaJFft0z4jPaeO14FZO4EgiLKFQ+9rIjPYhCNjUc9XVYxK7CrPRhEjLKtBBjqHR6tITSoFU4GfyI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3268.namprd12.prod.outlook.com (2603:10b6:408:6c::18)
 by PH7PR12MB8123.namprd12.prod.outlook.com (2603:10b6:510:2bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Tue, 12 Sep
 2023 14:49:04 +0000
Received: from BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::6d0d:ad1a:c6e7:816]) by BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::6d0d:ad1a:c6e7:816%6]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 14:49:03 +0000
Message-ID: <d96177aa-52ca-2015-7cb1-8d0a237b43fc@amd.com>
Date:   Tue, 12 Sep 2023 09:49:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 1/3] CXL, PCIE: Add cxl_rcrb_addr file to dport_dev
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     rafael@kernel.org, dan.j.williams@intel.com,
        linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        bhelgaas@google.com, yazen.ghannam@amd.com
References: <20230907191956.674833-1-Benjamin.Cheatham@amd.com>
 <20230907191956.674833-2-Benjamin.Cheatham@amd.com>
 <20230912151112.00007fe2@Huawei.com>
Content-Language: en-US
From:   Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20230912151112.00007fe2@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR17CA0033.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::46) To BN8PR12MB3268.namprd12.prod.outlook.com
 (2603:10b6:408:6c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3268:EE_|PH7PR12MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b9bb46-533a-42cb-5b45-08dbb39f685c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bk35JW5itVZoVsvaOnDu0HPMfQi/CyMwK1WTr42EbsgmdriLq06gpadNn4SByH3BOijyrwJbKXW30W2W5xT71Do0M5EbSvGlcZhASM3eELs5HGQyJ+GIsTYkzP+4LgiJcNQ6uD+mHrbfOeYgws6Bl4XRgdkZ/wvHZcpZfGffMON3cZAgxSNyfxaGLpUTjk1dxEiylAQRgxmorRgw7T2oKqYaWKhU8FMEHLxOxJlZS79ha4M7miG5qzswRwZBThBA3HIgjvDB+GW/lYcacqAjhswgRmUGFoubMfrmZcGTWM/Wr1AFdBJ/oUlRB4cwks+Bw4AUlGYfAD43FYcOkIaNX0nRxgDnIk7B/RKM/zqX5zh3G5fSiCcCwkQ8ciISQQqGWKoSB2mpHMyIqwaK2x7Ao+KD7zgYMUsU1iXntnMk5fMsLK3GbqoHmkeMGij/NRc4ff5Y/UM9T5JUBpA1STJzwuqCWBuT3Qz+MndD7hIS4qkQcRzT1Q0Jb7RnF6wYyn99YUcCEmpjiFrPWLG5WNngM1TMDm5PGaCXV33reWNAGruj777gFWCV+IlITFBAOjsX5AAZolWQWZoy34JAY+sz7VtZ8mqZPDQUROSrl1rC2gy48pKK853uQonzXMzIzNPZJRdOg1mNhU4eL7DpAa1PKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3268.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199024)(186009)(1800799009)(31686004)(53546011)(6486002)(6506007)(31696002)(86362001)(38100700002)(36756003)(26005)(2906002)(6512007)(83380400001)(478600001)(4326008)(2616005)(41300700001)(8936002)(8676002)(5660300002)(66476007)(66946007)(66556008)(6916009)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDhwNW1xRTN4YkhDTU1rYlZ4ZDlhMUJ5eGhZL0lVckJ6ZUUzeXpSYktGT1hr?=
 =?utf-8?B?dk1QcGhkTWRZa25TMzY2YXRRTGlaRjlaekY4UEIxSGFXOTZqYnFuTFI3MTQr?=
 =?utf-8?B?dWRkd1VVYllIU2duanFCS2JYdzloZGNLTmNIcGF2MWtZdGtXRGxTU0xpSjRj?=
 =?utf-8?B?bEloQ3F3U1ZLN0UwdFJkSE10TERyOVhDS2I2TlZMenZQRnduMFJ3aWxNVmJK?=
 =?utf-8?B?S1pFakcwbzA1cDlvTWpXeTcxbUhmZXowTm1aZEFObE0vdzhQRVEzaDd3N2V1?=
 =?utf-8?B?RFFnN3hUeVNzVU9mR2ZsNzRCWHVtVmVnYjkwVUJOL3pPb3R5cmk1SmZNS2Nt?=
 =?utf-8?B?MFA5bTdXV29rY2t4ZjhJaVFwN1dORWNvUE9GdHRLUHV4R29vOU1TT3lDMzNU?=
 =?utf-8?B?UFlNa2RLbWQzNzd0M25kNUR4T1FUNldaaFlqeHJOLzd3N0FvY1g5NC9ycklx?=
 =?utf-8?B?NzZSK1JrUDQzSUZQaVd6QVM3ZWY1ZkRlS3NCZmhGcnMySGFEWkJUZWdpQUd5?=
 =?utf-8?B?UlEwRlJYanprRjR5dUhZcmJETTJoWTNnUDBvU2tScmtxTitpVmM4SWNXTlhE?=
 =?utf-8?B?TU5FS1RCeW5DWC9CM1czYkxYR2MzUWg0eGZTUGJ2Y0R2NG9pOGNKSm91RTBt?=
 =?utf-8?B?UEhCTmZ5ZVoxRldRM2hQM3hFY0NJL0JuVlhjU3Mzd3l6VVkxdCtXWGo4R25w?=
 =?utf-8?B?dkJSKys3N2I2Z0xlS0o3N01tUGpBN2FBRUxnakJqN1ZBTUJTNmdndmhZWHo1?=
 =?utf-8?B?Tk9CTW9admFCSVJkSERkSlEwc2NpWDRtSTRxTHpjeHg4aC9RZGNJdnhQMFZa?=
 =?utf-8?B?RFBHQ2trQXRZOExxMUtxSzFGNU15WlVySVpoL21OdnNvU1h6dU1ieFc5ODVJ?=
 =?utf-8?B?cktqRkZVTGJsVE9yY0FwLzFudXhqMmFrZUFzM3ZqdFlGcERuUHRXVFFHNkwy?=
 =?utf-8?B?VG1SdTlzV0JJQWV4MkRxamJZTUgyaktCamI3ZzR6WUp4cGtCZFpuNW1IeG95?=
 =?utf-8?B?QXNSV3BCQWhlaCszTFY0cjdWMGlGMU1kSWlZaytaNDNlaDhBRDJYMmVHK2ZQ?=
 =?utf-8?B?NGZkQk8yZ0FDeW9McTJzQTV4YTRvbTR4MmJGSzZTOFhoZmNYQWZKWkUwOEE0?=
 =?utf-8?B?NW9sRHBlNHVpRVU5SURWK3VrYkpZUmFpdVFkcFd0S0Q1bW1NQUhvcmlyOGJR?=
 =?utf-8?B?ZWZSZktjaFMzdUJRZW9DdTBLVDhhMi9vRWRHSGNBaE5QTUhIRDVhVnB6TUVQ?=
 =?utf-8?B?UGFKMHlKRU82YlA5a2VMbWh1dEdzQmF4NXdXVzJZNmxiSkdpaEsrSDN3U3lv?=
 =?utf-8?B?MUFhMlFlRXhqZTZPNTZmV2VPdTBjWW5wekNjaFhrSmNCUjhiQzlXL1hEdmNu?=
 =?utf-8?B?M29DbnNGSDZiRVAyb3NObmJVOTZKYWZaZUxsMHJZVUIrRDV4Wkg2RDV1MWIz?=
 =?utf-8?B?akNVajlEUE9PNFRURmxjNElJd1hFYVMwdVc2a2d1MFdwMGtycG80alVrSlV5?=
 =?utf-8?B?RVdaaXBpbU9rcEN1SXZ0RGkvY1FRZUUxdS85WmcvSzhHb3Y5Syt0aWpHeWZ6?=
 =?utf-8?B?VGZYRjRxdGpYNzY1dVBudUxFRzloM3dyUndOVTVUdkJtZjY0YWVPbnE4dEhO?=
 =?utf-8?B?ZDBzemhmbUtDT1JkLy8zUkcrRmYrdGNFNVNhTWQ1MVdPeWcyZTdXUHpTTWRZ?=
 =?utf-8?B?cTJDbytCaWo2a0RyNjNweTZ1MzdLajc5clVNRE9ieWVrTHJUWDNuK3Jld3No?=
 =?utf-8?B?KzJmYWxOcGJpaGc1ZHFwaDM0anZNSUdDSFdmMXJZbWlDYVd6TExUSWt5YTNu?=
 =?utf-8?B?WGFad3lIWFFTeXlVTWs4V2VMeXR1eGtuVW05RDBkQUFsUTNyWTRkWTlSSjdt?=
 =?utf-8?B?M3V6dWFUaTN1MDRPSEZUcFR3YTRvNmNhU055cU9ram5FU21UTysybXNIek53?=
 =?utf-8?B?UzVhalljdExUYXhKSnF1WXpwbU9zYzNFOTFnNEhCU0M1bmZSSVY5NlJDdFpM?=
 =?utf-8?B?Vk1QSk5KQVdReGVXek1hb3A0K01TTlJoMjIreFJCMmlQVmFGblo4TDI3NWJK?=
 =?utf-8?B?bUN0MllqUlBTM29SNWNVUW1FMGFaQlBzSEhnSEJuN25qLzlTb2ZncUUyRlZx?=
 =?utf-8?Q?itWZid+SThFjOiOr2y8btTn+L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b9bb46-533a-42cb-5b45-08dbb39f685c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3268.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 14:49:03.6698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNDAPrVovRiWRp2lkrY9fDm6BHigiga8gUE93DVbVO4381+IuW3xvd4YKhP3OICJefLadWxgieN9OCLNaiMEow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8123
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jonathan, thanks for the review. Responses inline.

On 9/12/23 9:11 AM, Jonathan Cameron wrote:
> On Thu, 7 Sep 2023 14:19:54 -0500
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> Add cxl_rcrb_addr to the dport_dev (normally represented by a pcie
>> device) for CXL RCH root ports. The file will print the RCRB base
>> MMIO address of the root port when read and will be used by
>> users looking to inject CXL EINJ error types for RCH hosts.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> 
> Can we use is_visble to control presence of the attribute rather than
> race condition special that is dynamic addition of a sysfs file.
> 

Yeah, I'll go ahead and change it. Not sure why I did it that way to be
honest.

> You are adding the file to the linked device which is a bit odd.
> Why there rather than in the portX?
> 

I agree it's a bit odd. I went with adding the file to the linked device
because the ACPI spec specifies using downstream ports for EINJ. The
alternative was to have a file for each dport under portX (i.e. dportY_rcrb_addr)
which seemed messier to me. Now that I think about it though, I could just
have a single file under portX that you write the dport name/number to and
it returns the rcrb address. Let me know if you think that would be better.

> I'd also normally expect the docs to call out the non-link path for that
> device which is somewhere in the PCI topology I think.
> 

Yeah that makes sense, I'll go ahead and change that.

>> ---
>>  Documentation/ABI/testing/sysfs-bus-cxl |  8 ++++++
>>  drivers/cxl/acpi.c                      |  2 ++
>>  drivers/cxl/core/port.c                 | 33 +++++++++++++++++++++++++
>>  drivers/cxl/cxl.h                       |  2 ++
>>  4 files changed, 45 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
>> index 087f762ebfd5..a7d169235543 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-cxl
>> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
>> @@ -177,6 +177,14 @@ Description:
>>  		integer reflects the hardware port unique-id used in the
>>  		hardware decoder target list.
>>  
>> +What:		/sys/bus/cxl/devices/portX/dportY/cxl_rcrb_addr
>> +Date:		August, 2023
>> +KernelVersion:	v6.6
>> +Contact:	linux-cxl@vger.kernel.org
>> +Description:
>> +		(RO) The 'cxl_rcrb_addr' device file gives the MMIO base address
>> +		of the RCRB of the corresponding CXL 1.1 downstream port. Only
>> +		present for CXL 1.1 dports.
>>  
>>  What:		/sys/bus/cxl/devices/decoderX.Y
>>  Date:		June, 2021
>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>> index d1c559879dcc..3e2ca946bf47 100644
>> --- a/drivers/cxl/acpi.c
>> +++ b/drivers/cxl/acpi.c
>> @@ -676,6 +676,8 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>>  	if (IS_ERR(root_port))
>>  		return PTR_ERR(root_port);
>>  
>> +	set_cxl_root(root_port);
>> +
>>  	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
>>  			      add_host_bridge_dport);
>>  	if (rc < 0)
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 724be8448eb4..001ab8742e21 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -875,6 +875,14 @@ struct cxl_port *find_cxl_root(struct cxl_port *port)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(find_cxl_root, CXL);
>>  
>> +static struct cxl_port *cxl_root;
>> +
>> +void set_cxl_root(struct cxl_port *root_port)
>> +{
>> +	cxl_root = root_port;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(set_cxl_root, CXL);
>> +
>>  static struct cxl_dport *find_dport(struct cxl_port *port, int id)
>>  {
>>  	struct cxl_dport *dport;
>> @@ -930,11 +938,30 @@ static void cond_cxl_root_unlock(struct cxl_port *port)
>>  		device_unlock(&port->dev);
>>  }
>>  
>> +static ssize_t cxl_rcrb_addr_show(struct device *dev,
>> +				  struct device_attribute *attr, char *buf)
>> +{
>> +	struct cxl_dport *dport;
>> +
>> +	if (!cxl_root)
>> +		return -ENODEV;
>> +
>> +	dport = cxl_find_dport_by_dev(cxl_root, dev);
>> +	if (!dport)
>> +		return -ENODEV;
>> +
>> +	return sysfs_emit(buf, "0x%llx\n", (u64) dport->rcrb.base);
>> +}
>> +DEVICE_ATTR_RO(cxl_rcrb_addr);
>> +
>>  static void cxl_dport_remove(void *data)
>>  {
>>  	struct cxl_dport *dport = data;
>>  	struct cxl_port *port = dport->port;
>>  
>> +	if (dport->rch)
>> +		device_remove_file(dport->dport_dev, &dev_attr_cxl_rcrb_addr);
>> +
>>  	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
>>  	put_device(dport->dport_dev);
>>  }
>> @@ -1021,6 +1048,12 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>>  	if (rc)
>>  		return ERR_PTR(rc);
>>  
>> +	if (dport->rch && dport->rcrb.base != CXL_RESOURCE_NONE) {
>> +		rc = device_create_file(dport_dev, &dev_attr_cxl_rcrb_addr);
>> +		if (rc)
>> +			return ERR_PTR(rc);
>> +	}
>> +
>>  	return dport;
>>  }
>>  
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 76d92561af29..4d5bce4bae7e 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -690,6 +690,8 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
>>  				   resource_size_t component_reg_phys,
>>  				   struct cxl_dport *parent_dport);
>>  struct cxl_port *find_cxl_root(struct cxl_port *port);
>> +void set_cxl_root(struct cxl_port *root_port);
>> +
>>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
>>  void cxl_bus_rescan(void);
>>  void cxl_bus_drain(void);
> 
