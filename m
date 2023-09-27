Return-Path: <linux-acpi+bounces-226-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD2A7B0A30
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 18:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A0B2428159D
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897783C699
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:32:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B30B38F90
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 15:32:00 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5017F121;
	Wed, 27 Sep 2023 08:31:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKKLq8yc9DfMlUdw+pbzrFhdV5yPCJYnxcyiyIC/ZyO2DAPkj8nbBdyHBKChIDCh+5yreVdJFmZ01QC8t2Y/P8HSKeLjFg1TVjuSP5D49HrrztIxxOpXv+Etg6OqksWMa1KzeMy0z9+N2fTlAoHBWcJSLpF3kFFksWyxmWP0PS7veath2T3JJXo2/uoraS2mX3i8Kb0YT1OmA2K7QArRCOn2F9eD498ZMJ8TPf88LevQaibZqQbVMCLGqIBmYZQUpNhTd81Ip5JUSMHWPj2avhbJzXh8fkZtTBJSF2fSNLuHc6NqL/LhkaMJQ4c/6lgbqoRyKeS1MFz/gdbRE1jJkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9SseEj3oCOzJeeiWtSlJfm3VGR6OLzuqUD3ONEyuNY=;
 b=cxEJNgBpnKKtSeXjCve9f3IOjpHBLY/tvwf+Xod1oKMgyyAVCX6wdfcJGEl1yfIodHLQdWl/fQZSEwp2e4MveZ+1oI+yU15gi0s5+/Lo50ErQ4/rBQyizIzHTCFktFM6f8Y2luNI2JGO5w6twbaz8JAJY6WsDz25QMEKmWXnKlSmIGuJQBmpuqhqpWIwtHeWnh8NJNbi7mnTnZ0609q8Zv5/JyJ7DkPpRiwMx/kVpDTOmSbJNUF0a+PEHTjLhusrms9w6li4rHknDOkT7fTKQLXhPdsxRz+El1lcAK3q5f5jmZfs/GC+fLBG7i6pAKQIkyjWeSs4Ga9h8liX87Kh4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9SseEj3oCOzJeeiWtSlJfm3VGR6OLzuqUD3ONEyuNY=;
 b=FYQYgsUp8ZQZr7RI5OMI5so2sbP8//1YamW6236KPagbQxn4fZ/0oVjT+Ar4f2lgWeqLK1slo3Zkekbmj6yYHbk6zaDvKB9cSlmJKJy5oCRkmzCogURDhUpS2L7LKSplqfKjd3JHrgVMectsvUV8J4f4GP7flVqFqawIgeGcOmw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3268.namprd12.prod.outlook.com (2603:10b6:408:6c::18)
 by BL1PR12MB5191.namprd12.prod.outlook.com (2603:10b6:208:318::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Wed, 27 Sep
 2023 15:31:54 +0000
Received: from BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::6423:58db:9384:4031]) by BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::6423:58db:9384:4031%6]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 15:31:54 +0000
Message-ID: <38c50ad7-1879-c720-4454-fa52689039d7@amd.com>
Date: Wed, 27 Sep 2023 10:31:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 1/3] CXL, PCIE: Add cxl_rcrb_addr file to dport_dev
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, rafael@kernel.org,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: bhelgaas@google.com, yazen.ghannam@amd.com
References: <20230925200127.504256-1-Benjamin.Cheatham@amd.com>
 <20230925200127.504256-2-Benjamin.Cheatham@amd.com>
 <65134a03ab0ae_bf91294dc@dwillia2-xfh.jf.intel.com.notmuch>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <65134a03ab0ae_bf91294dc@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:805:106::27) To BN8PR12MB3268.namprd12.prod.outlook.com
 (2603:10b6:408:6c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3268:EE_|BL1PR12MB5191:EE_
X-MS-Office365-Filtering-Correlation-Id: 4598b157-e1bd-4940-41b3-08dbbf6ee10a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o6gFa1vNzTFUacb7IUURwFDjhzaVLwqJayVa4g6ZNrvhuPCWAp4zWLCdSeyKnuF7GmG369o2CiFrGSJJB9vTIpm9x0C3igc0l/O87KKLWZCGV7Clz98yED+nrvN9L/4ye+BNVWnJluRzrNjh37mhFynJU7U92hYQE2LVChM9lDGL2pDs7F10lYA2h69n4iIytcvvlB2B3A1Pzp+OG/ZD0HxSYBJAb/bU7KU1LwcyVQ/tcx2ceG5tCXC/uB4PNGNoQFmM23pPx8hOC3yAeF9rgWywvoPlsOC/uj1hDFxA/VA4IWJcaeLlvnW0K58UqZHzn+7dbn/9jV3EjFWTs9VOdtyiszDXbsp8h5Uv0iVN4hDdT0H5C6WdF6N/PSpdBiEonmxM9tUUk8Oomm79/eAT7OP8L6Fy1SNH6kOyoqBGd0zwh0a/Ny+Ye9buLTtozAfBsPTS4klaWyVveOLqezCF33h68XJqio0DzbHMGicYLevtygk8xelEB1qy6h/pio+Ey95h3sbrnIlUcsDWaBVZcWyCPrWjSn09ieb9tXaOOHJJ8wMqs+3JppMmoBo/XgkXOZln79HqKFwR9KSAjr1BG6QKidcXF2YaEBi7uvjCiuIhhQDe6drLUPuLN9J73KimZtA0ZGhKfvIXPwSOZOWkew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3268.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(1800799009)(451199024)(186009)(41300700001)(31686004)(2906002)(6506007)(66476007)(6486002)(5660300002)(53546011)(316002)(36756003)(8676002)(66556008)(4326008)(6512007)(2616005)(86362001)(83380400001)(66946007)(31696002)(26005)(478600001)(38100700002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YktRektsTm5yUm9IeVZpMjU2QkpXbHN6N0pYdFlzT1B1MUxkN2hFTnhEM2hG?=
 =?utf-8?B?bERld2I5OU9ON0pTeTVPK3lDU25xNkRPQ0xQZ2M4MjdONW1ESkNEUERBaVVX?=
 =?utf-8?B?dlM5WHMyTm9WTGhBM2pObUhjN0V1cjJUMkpxRFlKV3ZNVFY2YUYvQlJBUlZZ?=
 =?utf-8?B?d0Q2dGh6QS9VaHRSbE4rOFpKYnhWNDlXRnhqNzRVZGU5S3R1ckJvNUZVbXEv?=
 =?utf-8?B?dnhRbkxOd3BQdE1FdjYxZHgrTXRsMlJCNHZKdkZZalJuMTNwdW1sYjBqNk4x?=
 =?utf-8?B?SGRCZFYrRTVmTzllVkNCYytGaGFEZFliM3FBdE8zU1hmSDVwZ1REaU1kTkli?=
 =?utf-8?B?ZVgvL1lkdjdZN1Yvam5penJwK1VLUytHUXBzOW1SZDhpS0tBbDFyNFdaRkxv?=
 =?utf-8?B?RDROWFpNaHhLdlZvYzRPM1NXZ0tkWFBEN2tJdFUvZnlmUThQYWVlcnRSRnpY?=
 =?utf-8?B?N040OUpPZy9kRjFjWVFSMVI5dFE0QzBVRUVpTk5EUWJ3Y3NXVEkzYmxwVHlk?=
 =?utf-8?B?ZkYxOHF0ZzVJRkwxK05ZTmJDU0dDTjlwbW12R0J5bDVaVVh4MXgxOWFvOXlN?=
 =?utf-8?B?MFRyRDkvK2xHTEZJc3pCa05oaHppTHJna0ZHMGZqTkRaaDN0dUZaQjU5dWlG?=
 =?utf-8?B?T3Z3YUZJR2l0MkZ6YWJETzRPdzdDMXNEMlJIZG5TZXoyaXJTY2NkSGR1MVNt?=
 =?utf-8?B?VUdybVB1V2NmWHBGRkdzN05UeFc0cHkxa1ZTcGUwL0RDUjBlZGlGZnE0VU04?=
 =?utf-8?B?azZhUjhNc0trZEE1ME91N1plRjEvclQ3dm5XZytiZUg5V0Z2SUc5UVMzc3VJ?=
 =?utf-8?B?S0VPVGlTMkxEL0t0ak1tWWpQV3FnMitsd0dsbUgxcmFLNE0xSHFudFFxYmkv?=
 =?utf-8?B?S29pcGdUUWQ2c0tyazI1UWd1ZVUzRitWazAxaXZCMVRpbDR4NThNdHk4RkJy?=
 =?utf-8?B?THJkOVdWUWV4OW11U3FaV0x1eUlERXd5T2RLWkVUK2VGdEpoVVdBSWZwNHpz?=
 =?utf-8?B?cU91TUxFUUVLREZDVldGZnpqVENoRUZSZkxiZ1B0dml0RWluSWsxWmtjU2tU?=
 =?utf-8?B?UjBLeUlROXUrd3pUNEFBRUxiVEQ1MGZNMHBFMllxVWx1OWc3Y2pMTzd3bm55?=
 =?utf-8?B?dVBNdllrNFR1UzY4SVdFUUlidVkvSUxYMGl2eTJHMDBkYWo2TzFSQnV4NDRG?=
 =?utf-8?B?ajZiaUNCVWEvcGsyTnJsQmg4QkZ3OHpBZ0RKbGREWWZybUtiL2xRVHRCd3ZV?=
 =?utf-8?B?YUtKUmdteGVvR0VCRmZyem02N2ZSbklBQXZadWlZVUNtYndCNlZBelBwdWVz?=
 =?utf-8?B?eXdXc1NuZitlcEo2MHNQcGczS1JuS0Z5Q21uc2E0TDcxaEd3L05TM29vQzl6?=
 =?utf-8?B?Z0huM0tGUFd5WTJFWVZ4T3FGT3hCaEZiMHVlZ0d3Tk0zRWh4bXd3U0NqeHY5?=
 =?utf-8?B?WnpKWlF3dW1LVy9QNXFkQytManI1UlVvaFY0MzF1TGczTmErT2JxOG9nbnhh?=
 =?utf-8?B?NFBYSEZOVnNwc2lxUkg4Y2c4OW9OMzhQSFZEK0o5K2RObmxHMGtJSmtVUGdZ?=
 =?utf-8?B?WWFsaVRQS1dzRlJ5R1d1QklZU29xRVJMWUVDck0wS0ZWaEZFTXVVMzVyWC9D?=
 =?utf-8?B?VTZVcGl1SXhTQUxSdTFJaFFnNlZaQlpLc09kM1AxZnhKa0NrYlhvRWdWd0ox?=
 =?utf-8?B?emVLeE0rVlJKa3VML0hwSE1kOUV3a2p5by9pNEFaTTlma2Zkb2tkRkVQNy8x?=
 =?utf-8?B?MlNjTGc0RDk2ZWtwSlRTRi9qOTl1L3VBVHA0TXVBZXBvYnB1YzJYQTV1cmR3?=
 =?utf-8?B?V3FPNTN4bi9VM0RtQ3JnTmVNTFhGRzZDM295WXJxN1NVUm5xR3o3VGNVTlVI?=
 =?utf-8?B?Yi9RU0lUcUF3ZnFrb2ZFc2pRUXYyU1M3NkkzN1pVQnRuTUh2SGxNU0ZqUmtp?=
 =?utf-8?B?QzU3VUxMWVVBUkxTeGZvNkw5RUxJR1lNak50MWNOSU8wTmxLL2NleGdTbU8x?=
 =?utf-8?B?LzlCTjY0K01GU09GZWdQaHl5ZktXR3Uwd3d2RFJXNXFpcVhDaHdDbkZrenRJ?=
 =?utf-8?B?dHlCZkNPdU14WWFLVFh1WHNGTTRyKzZKRlpmclMyU09wS08xZjBIejlPaDZn?=
 =?utf-8?Q?jB7TTdA5JiSIOCJSTm1EiLEO5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4598b157-e1bd-4940-41b3-08dbbf6ee10a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3268.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:31:54.7273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfgOtMo7fJpJTIc3oe3J8/KkFCl50gJn0IhUTglK1zEFfy8cQE/A4S2zSPPUYaCGeMPBVXw/6uOXvpQGriwziQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5191
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks for the review Dan, responses inline.

On 9/26/23 4:15 PM, Dan Williams wrote:
> Ben Cheatham wrote:
>> Add cxl_rcrb_addr to the dport_dev (normally represented by a pcie
>> device) for CXL RCH root ports. The file will print the RCRB base
>> MMIO address of the root port when read and will be used by
>> users looking to inject CXL EINJ error types for RCH hosts.
> 
> RCRB is an implementation detail of RCH topologies, I don't see why
> userspace needs this information, maybe it becomes clearer in the follow
> on patches, but I would hope this detail could be hidden.
> 

It doesn't, I'll rename the file (if it stays at all).

>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
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
> 
> The cxl_root is not a singleton and the way to determine this linkage is
> by walking up the port hierarchy. See find_cxl_root().
> 

Ok, I was under the impression it was and couldn't find anything definitive
in the CXL spec about it. The reason I did that was that I couldn't get
access to the CXL port hierarchy from the EINJ model and needed an
access point.

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
> 
> Please no dynamic sysfs attribute registration. If this attribute is
> needed it should be static.

Understood. The file probably won't stay in v6, but I'll keep everything
static.

