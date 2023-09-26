Return-Path: <linux-acpi+bounces-149-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474CF7AF0C4
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 18:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id ED707281BE8
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 16:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E4A34CC5
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 16:31:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA69A30CE6
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 16:00:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B302FFB;
	Tue, 26 Sep 2023 09:00:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGxySiCM0SWZFRfP6GSTzEzWR5frtmmCyDsqN/OfPLNN9a2DO4iurcIBQ64GlBBc7DT3cfjelhmRWPqHOm3aVQR5DJTteyCagDAxQMXOE4wxXs1IY6uHndCN8dnTiRT9S7QbNYAMLm2+eM7k+DlIvZVd4Fl8np/EJzTw4gJvs5N0lzUvOyhIg7ZlueQrXAxenJPJHhq47CVchTBjH+C3jv/p5HhGO9teJcba/Q1R1su8WMKd/lTkoAVKt8gLURUlO8rLvC+sQERdT3g+qipUxaW0fGaDe1aKEWMSUPFlkOyChAZtqJacqCot78khWDP/m712pMl2pv6cnWswSHjImg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Xdixd7i5eWC0Ess081zfDzdaOA0QcnWFGE5Nlt19VY=;
 b=inivkXziyqtU4XXqypBknPytoM/9Ai6YoxHdVkagF1+TLHEO/zPbWetE/KKDlgBBAjOHl/Ln9sNJaHABPmUg8VlIacGh2Y+fYIsYCOf3gU92K2A4QBReKCYFcAdD5xK+W6I6bB4fuVi5pMigKwESf9TNwyUTzja1RwnLiZcFsxA4nonaib7FwKbUS85L030172Fnrqrq3OXAa8s1amXkh5S/o8c3YT7fHCLtnlgevdvZwSFoY1z1piXyyfunNnUBWklwaH6dTPTnROuqs7w5i1wg7oSbvbFbNqM9iqB+WCEJRr/eSe4vR2EDK5pMkfq0tS+UZQJ12NkODCnBmCiilw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Xdixd7i5eWC0Ess081zfDzdaOA0QcnWFGE5Nlt19VY=;
 b=u+yHaKLF3QKOAAkVQLB9PAHw9p759FVNNl7kSXaEZVVu/Ujlnv8XcWGvzfncnnqCkLH1DfpmrCeeZCwBN/6HFoQ7okb3tAHJtAJtQ/xuIvxyat4PV2+WFypOGrdvSLD6Wi20X6jWZX9G2h0uuciAWvDF/pbjZ+zywLbJqKyJjtE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3268.namprd12.prod.outlook.com (2603:10b6:408:6c::18)
 by PH7PR12MB8040.namprd12.prod.outlook.com (2603:10b6:510:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 16:00:27 +0000
Received: from BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::6423:58db:9384:4031]) by BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::6423:58db:9384:4031%6]) with mapi id 15.20.6838.016; Tue, 26 Sep 2023
 16:00:27 +0000
Message-ID: <0b8461d1-9c03-8315-b4b0-1ad3ee800262@amd.com>
Date: Tue, 26 Sep 2023 11:00:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 1/3] CXL, PCIE: Add cxl_rcrb_addr file to dport_dev
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: rafael@kernel.org, dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, bhelgaas@google.com, yazen.ghannam@amd.com
References: <20230925200127.504256-1-Benjamin.Cheatham@amd.com>
 <20230925200127.504256-2-Benjamin.Cheatham@amd.com>
 <20230926115044.00006895@Huawei.com>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20230926115044.00006895@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0515.namprd03.prod.outlook.com
 (2603:10b6:408:131::10) To BN8PR12MB3268.namprd12.prod.outlook.com
 (2603:10b6:408:6c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3268:EE_|PH7PR12MB8040:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c9ece7b-d303-4928-75f3-08dbbea9b396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2Ar2j18BAntsws2cAOInkpjjMVWY2YTPGEGvC+wGbZVLlz9Kxmb85i+18PKSlBnHzoLf9FFnd5+DTQYJl93Ybiu7GA9KgAUbQYA1+m1UUw/sz8XMky6gqJW1okGKCpqX3Pk/MkhNoVZ+XCwhty6KmamtQD2B45AthRMmeYXz2rjM19ritO+MxAMaZwiae4OTpYBfBMjwqZ0ce4+QugH0bjXl5KXKa+UX/RNaUEFrRI7y7Sc9yRFo0Gph9N+OK5pQtEZp8x8nEQEnf4/1kxKxpX3pgxsq3rrEc1Dxow8XRRSfnEgtxhKz+llGTWRpjBh5Nfin9WbT1ljlhQe17CWAcQkTci1YuA0fWgQw3k6HKw16LehgwVTUv0y1v0Hw9lHUpdvWDbR3l2S58vRseKjA2wbOGlz4tGF4ycKp3G/Yun/FrHjqSG1BcVv8ZdEQOmNO3T5ThR4+BJbkAoC6kbJBLo6muUk/ELoSZ51E1CpDXMCogs818gKXh6ID82uTuJyPWOuDjrXTMO+Q8smyxQzs1ls0/GJTwOMvebBiMhdVLbPonH3maKmdZy9zeplGDjqgaFtfguD41qiEkluNZGDTtyZz1E8GfUEDmDYQ7qZGLJT9oX3BnfGKM1xr3TAHnDmvi2FTJnPeB0UK09VDUGNG1g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3268.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(1800799009)(451199024)(186009)(2906002)(31686004)(5660300002)(66476007)(66946007)(66556008)(478600001)(6666004)(6512007)(53546011)(2616005)(26005)(6506007)(6486002)(8936002)(4326008)(8676002)(316002)(6916009)(41300700001)(83380400001)(38100700002)(36756003)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmNxVEdFYmpDR1o0THM5RnQ1Y3BFdVFTbkhkd0JyTWdRc2JCK0d1ak05TmMy?=
 =?utf-8?B?akYrYStkdUMzTzYzT3JldVdiTWlKT0NTcEx5VjkweUFSRG1UMnFnKzhhMDVP?=
 =?utf-8?B?aldXZk9IZzlwSUlpQnJwNjg3a2JoMHp6My9POE1vT2VhQlN3SzdKdlNpR1BD?=
 =?utf-8?B?SXByVHU2eENaQnJFL2RkaTV6SlZ3bTl1dFFYVXloeFZuK2VtNHpJMmVURUFy?=
 =?utf-8?B?MEJsRy9rTzZBS1FmRk8zSUVJbk5sT2lKNTgvZEFZTXhTeTBCOGhBQWx6dWJq?=
 =?utf-8?B?WGZBMWh5NHhaR2NNNTA2aUlRRGd3S3ROTnBjZGJwUUlQVTRtYzhPZlM1SzBZ?=
 =?utf-8?B?NnpvT3U4UTI5YjdyVWFCUjQ1aTd1MkpwYlQ1STZpd2hmdXF1S0ZjeWRiOEVk?=
 =?utf-8?B?dU5ZVHpNNG50dlRVT0FTajQ1SGRwb2NaSGZqaFhZSFdjOUZIWG05UmZuK1Nk?=
 =?utf-8?B?WGI2UXBTajJ5cCtwZUhWTCt4dCtxUUpUc3EvZkthNyt1VW9rMzZ1OTlTQVB5?=
 =?utf-8?B?SnJKSC9sbmphenovV09IOEpldW5QSEFPTDRFUml2VlBZR2FkeEdWb1djUlN4?=
 =?utf-8?B?dGpGYlo0YVAxN2txMWJLQ0NubEY5TTRkUmNBdEdKMDdhS3lnOFlaZGRScUlr?=
 =?utf-8?B?YnBYZWtqVkdRYnlxa2NMTFFlOFdyQ1hEVUtUVWg2TGUvN01vRWZScnZqcHZz?=
 =?utf-8?B?SVJTNEFZL1Vkdm16ZGp3aiszWVl5QkVoZVQ0eVdlS2lYSFIxVHZ2dnVPKzNK?=
 =?utf-8?B?c2gvNDZkL09TV0JuTlBmamltcWtFMmF6WWsyWjJBSm1xYzU4Z3VVOFhDQWhz?=
 =?utf-8?B?cnJFM2l4MFJRbzc4elBUcitjWDd2NHVTWXFOblV5ZHNRRyszaFlaUWRsbm5y?=
 =?utf-8?B?clNkdHMwREVRL1ZidERGZHNWMytldXIxMFlEU1dNUHp1NXFKMndJTjQ4dEtY?=
 =?utf-8?B?K2t1a2JtY1dRNUxiOEkvRkRJS2RTK2hPRDBvK1ZnZkRmZW5VS0VoZ3R1Z1o4?=
 =?utf-8?B?SVc4TFM2alFBZldCVTlVM0ZqM3JQalFsWW5mdkw2VnBSUHVySWQ4QlQ0Wkt6?=
 =?utf-8?B?alJ5NEhtZHRVbGVxRy9Cd1MzL2hkYURJK2JvdTRqMnBWMC9OUERhVzJpN2pI?=
 =?utf-8?B?ZVlzZFlEL0FnRHdEWlJIcEhhSE5GMjRobTBxN1o0Rk1WeWpPcW5VUnppRlZU?=
 =?utf-8?B?NGRGeXFwWGJtNjh6N250Z2gydXpUVDNrV1VDRnovWlV1VUtkV1ZHSmhPTmpR?=
 =?utf-8?B?TGYwOG5ReEdBemZoSm8wOVRrT2FwSTNIcVdwcGh5K2FiRFdpVTlKTnBQdU9s?=
 =?utf-8?B?MHhxYmZ3ME11UzQ4SWFQZU9QNGRjQS9WU0h5bWdOajdwNE9MOWRpd0hUL0hP?=
 =?utf-8?B?VXdRSUQya2Q2aVFBYUhvQzEvbGtuVWx2djhmMTEwSFJkNWc0RG5CWkRCVGZo?=
 =?utf-8?B?ZWZKLzd0VkxodUo2RElGbnA4Z3dZYWo0eXpVMFdTWWJjZ0dIaS8xZGVqZTBG?=
 =?utf-8?B?L0o1U3p2VHpjZm1iSzA5Q2g4MnIrYkY4Uzk2cEVxSFNTdDhGMDFoWmhyNnpL?=
 =?utf-8?B?Sk11ZG9sV2JQcUIvS3E5RUg5TkVSM0h0WnBmTnBXSU8zQWdNbmJXZ3VOVnFO?=
 =?utf-8?B?cmM5WFZLOWMxTTVFUHFKYVV1aFNFOGhnWVpxK1JLWDJvd3BhV3Nuc1I2bE5Z?=
 =?utf-8?B?MGVTUlZTTFZvQ0NxQ1E0K2JFK3hHUi92akVTdGdqQ2tYdE1yRTlaeS9BOWFL?=
 =?utf-8?B?dG1PSk94alV2L0hrYlZEdldDVEVXMytOb3U5TU1DSVFDekZPaHNCMnRNWGkx?=
 =?utf-8?B?MVh1VndSaFNsZ25mUVNWQk5YWDVoNlpPQ0FRYWVEL3V5cFY0c1lHOFpzSTVy?=
 =?utf-8?B?QkI2MHAvVXFhOWdNaWFFNUVmQ0VkNjk4aG9mN3NCY0JLY1hvT3p0UFdmZ29n?=
 =?utf-8?B?MEU2K05abkVLQnRzV1BteXZnbGFaQkErNHhQMWZUbThhOEYwZlF3VFJGNWhN?=
 =?utf-8?B?MUtabnZRdUlGU0h0eFJ3RWNjYVZLYmxZa1R3S3ZIcW15cHgxcnNUbjJvNkVq?=
 =?utf-8?B?QzAxaEJrTTkxb3AwOVgxejhGM0krSFE0bWtFQmtpMk9MMUEvSFdwTnpSRk8y?=
 =?utf-8?Q?upongjwp7Zm+F9/CuMCIk6XD/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9ece7b-d303-4928-75f3-08dbbea9b396
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3268.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 16:00:27.7822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sfr0Y5NS2oeckEDo8JMMC2ozhypiCaxKIl4V7VlWAEydI8p12bToUnBsEloyvFAit1eJZQMwfxdHiSq3hHzyFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8040
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jonathan, thanks for the review! Responses inline.

On 9/26/23 5:50 AM, Jonathan Cameron wrote:
> On Mon, 25 Sep 2023 15:01:25 -0500
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> Add cxl_rcrb_addr to the dport_dev (normally represented by a pcie
>> device) for CXL RCH root ports. The file will print the RCRB base
>> MMIO address of the root port when read and will be used by
>> users looking to inject CXL EINJ error types for RCH hosts.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> Hi Ben,
> 
> I'm still not totally convinced that injecting the group via the link
> onto the PCI device is necessarily a good idea, but if Bjorn is fine with
> that I don't mind too much.
> 

I'm not 100% convinced it's great either, but it was the cleanest implementation
I could come up with at the time. I'll try and see if I can come up with something
better if I get some extra time in the near future, otherwise I'll leave it as is
if Bjorn approves.

> There is a question on whether this should also be added to the
> sysfs-bus-pci docs given it turns up on a device where people might look there
> first.
> 

I agree, I'll move it to sysfs-bus-pci. I didn't move it this revision because the device
the file was on (pciX) wasn't under sys/bus/pci on my test system.

> So with that in mind
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
>> ---
>>  Documentation/ABI/testing/sysfs-bus-cxl |  9 ++++
>>  drivers/cxl/acpi.c                      |  2 +
>>  drivers/cxl/core/port.c                 | 58 +++++++++++++++++++++++++
>>  drivers/cxl/cxl.h                       |  2 +
>>  4 files changed, 71 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
>> index 087f762ebfd5..85621da69296 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-cxl
>> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
>> @@ -177,6 +177,15 @@ Description:
>>  		integer reflects the hardware port unique-id used in the
>>  		hardware decoder target list.
>>  
>> +What:		/sys/bus/cxl/devices/portX/dportY/cxl_rcrb_addr
>> +What:		/sys/devices/pciX/cxl_rcrb_addr
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
>> index 724be8448eb4..c3914e73f67e 100644
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
>> @@ -930,11 +938,56 @@ static void cond_cxl_root_unlock(struct cxl_port *port)
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
>> +static umode_t cxl_rcrb_addr_is_visible(struct kobject *kobj,
>> +					struct attribute *a, int n)
>> +{
>> +	struct device *dev = kobj_to_dev(kobj);
>> +	struct cxl_dport *dport;
>> +
>> +	if (!IS_ENABLED(CONFIG_ACPI_APEI_EINJ) || !cxl_root)
>> +		return 0;
>> +
>> +	dport = cxl_find_dport_by_dev(cxl_root, dev);
>> +	if (!dport || !dport->rch || dport->rcrb.base == CXL_RESOURCE_NONE)
>> +		return 0;
>> +
>> +	return a->mode;
>> +}
>> +
>> +static struct attribute *cxl_rcrb_addr_attrs[] = {
>> +	&dev_attr_cxl_rcrb_addr.attr,
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group cxl_rcrb_addr_group = {
>> +	.attrs = cxl_rcrb_addr_attrs,
>> +	.is_visible = cxl_rcrb_addr_is_visible,
>> +};
>> +
>>  static void cxl_dport_remove(void *data)
>>  {
>>  	struct cxl_dport *dport = data;
>>  	struct cxl_port *port = dport->port;
>>  
>> +	if (dport->rch)
>> +		sysfs_remove_group(&dport->dport_dev->kobj, &cxl_rcrb_addr_group);
>> +
>>  	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
>>  	put_device(dport->dport_dev);
>>  }
>> @@ -1021,6 +1074,11 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>>  	if (rc)
>>  		return ERR_PTR(rc);
>>  
>> +	rc = sysfs_create_group(&dport_dev->kobj, &cxl_rcrb_addr_group);
>> +	if (rc)
>> +		dev_dbg(dport_dev, "Couldn't create cxl_rcrb_addr group: %d\n",
>> +			rc);
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

