Return-Path: <linux-acpi+bounces-223-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C84CD7B0A2D
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 18:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D8834281596
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9CE3C684
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:32:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FA31170B
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 15:30:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7344E126;
	Wed, 27 Sep 2023 08:30:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRC+CEFnHTvC2UJ0RIyXazIWHw3sw0FHNvfkRFGMAwEp0FXAUMFMOVMFr8EIc3ZjN2vakE4FTT/dw1W9kbpnpSMGe5pLwIbvKR54L9kYmhY9lKPTTqnHeI5k2KbfQc0AZTckrgEHS9U0XDULa62dVzcqFBBFMjRHj4O+E+jvCXz7iykEZv8stRYi5lqMVPF645wbtxlbipA7jd37pJj6x2sDhBrJatR5iA+1DCy0iJh6FL4jMMe708kwGASvjaLNqn7VYPNsSi4ihqxT8mhiDssAjzupeGhcyTjMzVn0zdRrc2vUAW5alIgEqaDe8yP1zge/KEZV93VodTO0ikzOCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXJWf8rrcYcfEzv8UZXj2iSYXH+jlwx4U2226U0hco4=;
 b=UfhdCft/rkWs6OyeP92aMlFM27kTR0g40Xz6gHlLMLl2gezFxqq+bTDKR5W8OpXrBASJJaOq5+D6T6jfci0CalYngbUuPPIqCmbT55Y5pTJsMoJ7r1GW3k1zyTkWPj5Nc12dE9bvVTOz1xApshb66lwmnXJmG0GeSPWKAZ0iKPCf7ifbxniBUUF0ZryiY8aNo1X0seus3StsPrWM91mNafkiEUK99ikdyOgt7z3S2lfMsNWO3RQPr9DRiwG6vjFnnZpFwcg0CjvH5e/0uqTIp+DH4BMxWVqv94HNZ5YCWqGI0Tupm5cdDxv83pkPcvagh2VEPQJis7jLjs2OwhMLyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXJWf8rrcYcfEzv8UZXj2iSYXH+jlwx4U2226U0hco4=;
 b=pfs+urNRxZztfH2bikmIqclWqCaPb5wj8JHeQDcLBydXAxC6MHTwtqu/579w5K2wM8AC9Aj7rjG51c7a4zh3xDTLYexAJI95sOzrboq7Ers7TQIl7KRrilbDkuPKKszJxB4/CM7LRMogQKzIdLcRR48UR0/5r04Vagg+H9kPKNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3268.namprd12.prod.outlook.com (2603:10b6:408:6c::18)
 by SN7PR12MB7417.namprd12.prod.outlook.com (2603:10b6:806:2a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 15:30:31 +0000
Received: from BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::6423:58db:9384:4031]) by BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::6423:58db:9384:4031%6]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 15:30:31 +0000
Message-ID: <f449aa4c-11ac-89a4-7f45-c32d44ac366c@amd.com>
Date: Wed, 27 Sep 2023 10:30:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 1/3] CXL, PCIE: Add cxl_rcrb_addr file to dport_dev
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: rafael@kernel.org, dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, bhelgaas@google.com, yazen.ghannam@amd.com
References: <20230926202343.GA419574@bhelgaas>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20230926202343.GA419574@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0007.namprd11.prod.outlook.com
 (2603:10b6:5:190::20) To BN8PR12MB3268.namprd12.prod.outlook.com
 (2603:10b6:408:6c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3268:EE_|SN7PR12MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: b3dca19b-6146-426a-2de1-08dbbf6eaef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RUhh+rxZQBi7a7nMaZ9BusGImZI78w++zNLJh+DhtL2yfizzkcVdWyH3BLCmFLJ4lnLLw1Zd+uZr/UI6nGaQol3gLu2eqFp/IDfDyg4M/hyxD944csPPmTpbCB15/UlT9kkZalTNPEVacmYQv5pSlLEcp6CiC3vkfzLKeKagRM5WreiKqEdIXBMxjdaXLNDp0Ft/z+DJ8R3n0ra7hOSRVToMpxHzQBI/i/9nIrUHSQ7X9KMswA7S5gr2xev+JuTger96pLEFqR4ra9aOX1l6vUsdHbl+mak41UwZzF2ymZEKbfx6m9OyGvDUKOOrpBoUCKLcSdz1On0s1ncuCPV869nXcAZZ7fgMiQ6Y7pVmN1Gv0utPSxCyoX+/xweRSFPs7LRCQwHE9rP1UaYoeG/j/pCTjj7Zzew3rLl7YTauwk7tFj0iuxHBiobw7RvduLmhOoX7Dh7lGgMy0Z69OwExgXJP0UTJuYZBkW91kDYE0Q9Ca4gXGCrzUNCwa4oYsNLEhnnVZDCac1nF0rXQbHZaG8/047abRIOzjyF4LknMIOq6owFYd58u4oKCvpjwbHv4yse1t8gPBqIRjEokvo0g6s0qwGyJr3eGL+RDGZ/+VhDcNSg4mj78KOd3pW5OfeFISa2Ylygum4Kf6wcvo4tHmw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3268.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(186009)(1800799009)(451199024)(316002)(5660300002)(8936002)(4326008)(41300700001)(8676002)(66476007)(66556008)(6916009)(31686004)(66946007)(2906002)(31696002)(53546011)(2616005)(6512007)(6506007)(36756003)(478600001)(6486002)(83380400001)(86362001)(26005)(38100700002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnkvR1FnRXU3Qy95SnJrMFlJbkw0Y0w1RHZ3d0Fkd2x0TVdBeEw5VGQ2bkxo?=
 =?utf-8?B?Sm1BWGl2d1JQbTh5VVljdWNhSkhqaDZlSU5ibGt4cnM3T1FRUTRSY0NPN3Rz?=
 =?utf-8?B?Wkc0cnNGM2J6VDQyZWJqZm9PR0d5T3M0TktxNFVpNlpsME5GdmltcGJta2U2?=
 =?utf-8?B?QjR2OVo2OTlwa2xoWC9tS1dTa1ZYQysxZlZaZVNpY2xRdVVHMHdzdWZ1dG5E?=
 =?utf-8?B?aXZ0TlhzWFYxUjk0b2MraTdaWlgxbGxwTW1yRXY2bk9JYTkzd0t3YklWMVp3?=
 =?utf-8?B?eU5ablNSNnBVNDZTbDZkSEx2TUFWTnZDWDlCTVRMN0xjWmJrSFhoOCtSclhD?=
 =?utf-8?B?eCtrS0FhYTdXTjZITERmbTJOUmp1dmU1bGRWSzZHMjlVTFhrcXlZTDRka0tT?=
 =?utf-8?B?MzNXUzBBcWZBbXJSTHlaUHBjWEdUNmdNZlVNOGU2b3FxalFQdW01Z21ITnll?=
 =?utf-8?B?MEZCckVNZGt5VEpjQ1dGamQwbm9ob3JTbmtKcm9jak5DaC9XREVYR3doK1Va?=
 =?utf-8?B?UmEzWVk0Umo4bHptN3VETXB3RmZmclQvbU5xaTR4OFdYM0FPSjU0RlpmVXRs?=
 =?utf-8?B?alk0WVExQ1FCZmc4bGpBVlpKWmdKdmZXUzYrd2FtK2pUTjVqUW42anJYRDhz?=
 =?utf-8?B?djRWSlJLcldkbTVjMTRVMXE1eHlLY2V5WGE5YmQ4ZVloYUVlSERna0lnTmtk?=
 =?utf-8?B?VCtheVJLNklFeGFISExLUlNLcVc1VFpGMXZmSGF3SGJpQ2xoSnN3NEV4YXRQ?=
 =?utf-8?B?SDc5ZERPbndaZitiWWE1NllPVW4xWGJWdENEUVNHRTR6MnZBOUM5VDlES3VV?=
 =?utf-8?B?M2o5T1BqY2U3Y1VkM3FjLzRZSUo4dDBqQTVmWENEbjZhVTVzMVlwT3k1OHBV?=
 =?utf-8?B?MldBV3FxRUpxZ0pibGJ1QUU0ZVYzYnplNUNzZms0ZWdkYyttUzZlYzM5T1lq?=
 =?utf-8?B?ZnFETmNGU1lDNk5FZm5heWl3ckY1cEtwMVd0QU4yUG5pcVdYOVpXWEQzK0Uz?=
 =?utf-8?B?WTRRbE4xMVd0UmNQcElXZnU4NkhSOFo4R2Jvc2c1eHNVOEdCNlhINEZsSE52?=
 =?utf-8?B?b0VoMm5YU2N6WkV3OHVMY0dVSzJianZ3Vm5DekczMStnOFdwMk9KK0Y3T3Ez?=
 =?utf-8?B?QTYzeDVTUlU5dkI3TmtZRGNzbTNKUnVqL3pWbjBnK0F4cjA0SGo3RGdqMUhR?=
 =?utf-8?B?b2pFa3RBSU4rM09vYXQvV0ptcmVwL0ZxemRURzVCRHNRMzZJa0VGa1BRWFdP?=
 =?utf-8?B?VFFNZWFjRENsY3ZZNmFvVUtrMVNrbExMaTQ1WTVUMzVLVFR1dEpjWjFsWk9u?=
 =?utf-8?B?eVoxUUFaN3ppTmRKcHhjdkx0REQ1aUs1OEsvVVNrRVR4SEFJaCt4K3pWRTFv?=
 =?utf-8?B?NFhSNXBuemY5MERlTmoyOEF3c0d3aTFhWTVXMlRoTGJ0dkZXK2tJQmxlUmhp?=
 =?utf-8?B?YUFROE1rTVdiTTRnWVBiclh5U2s2RUE2OS9QMTA1aHVVRm1hTkhKbTJaeVRx?=
 =?utf-8?B?cWZOWUo5ejBrY0NPZ1o4TEN5THp3bGFBNGtDQXBxOE4rKzk0VDBuRXk5MXVT?=
 =?utf-8?B?Mkk5eVAwVEVLN1VCUHYyK21WS0g2cGU2Rk1Ua1ZOMWV4Z3VyU1JGNkRPMWlW?=
 =?utf-8?B?YmRrNmpzRUFlS1RVUUlaSE4yTFNpNEthaGlFcGYrdDBmUXVqQzVyTUFVZEJs?=
 =?utf-8?B?TURqOUFzVzBzR1FsTjNLYUowN1ZRbDFac0JsRTRzM3ZidWJqeStQWFQ2NXVZ?=
 =?utf-8?B?czJzTE8vU0RPbEFkUS9zVCtLVHhvSUNPQmtkZjh5c09Jc25wUzY0bnY5ZzFt?=
 =?utf-8?B?eVQ0VkJIbjJXYmtBdysrQWFOejhKOHhTTWp4cXFYeC81WlEzblVyVXVKN3dU?=
 =?utf-8?B?cmF5cWFudkZhQnJueXgvM3BveVpqQzJyOFhldENwWDVQZ2dqWjR3MzFPYXVv?=
 =?utf-8?B?bGtadXFTVUx3VjRVVXJIRHhrc0V5ZWJOMXYxclMrcHYrNXVMS3dOUTlQem10?=
 =?utf-8?B?dkJNYUlWWlQ1c015UjVkVis5UHlIWEUyeEt2aEkwTFNibG1XSUlnajBValc0?=
 =?utf-8?B?Umc3SHh1aFN1YTgyNDdwMFVsbDMxaXFsYlI3eDNKc2ZvaEJ6aVQ1L2FvSytk?=
 =?utf-8?Q?t/IAGp/DmxcxBev4xN6SzOIGn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3dca19b-6146-426a-2de1-08dbbf6eaef0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3268.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:30:30.9755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WH4RrClbjc0HcUFewSUbTHecdIWmuXfUTrl0KGY1DqBZ8xVEFBMZg9rwInHgQ9uo0827BgKWyp3L7nIP/mUM9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7417
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Bjorn, thanks for taking a look!

On 9/26/23 3:23 PM, Bjorn Helgaas wrote:
> On Mon, Sep 25, 2023 at 03:01:25PM -0500, Ben Cheatham wrote:
>> Add cxl_rcrb_addr to the dport_dev (normally represented by a pcie
>> device) for CXL RCH root ports. The file will print the RCRB base
>> MMIO address of the root port when read and will be used by
>> users looking to inject CXL EINJ error types for RCH hosts.
> 
> I guess this is talking about a sysfs file?  If so, maybe mention that
> explicitly in the subject and commit log.
> 
> I don't know how you decided to capitalize CXL initialisms and not
> "pcie", but I usually use "PCIe".  
> 

Sorry about that, it's a typo. I should've written PCIE/PCIe.

>> +static struct cxl_port *cxl_root;
>> +
>> +void set_cxl_root(struct cxl_port *root_port)
>> +{
>> +	cxl_root = root_port;
>> +}
> 
> Is there always at most one cxl_root?  Seems worth a one-line comment
> at the static data item, since in the world of devices, data is
> usually in a per-device struct, not in a single static item.
> 

I thought that the root was a singleton, but per Dan's comment it seems
that isn't the case.

>> @@ -1021,6 +1074,11 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>>  	if (rc)
>>  		return ERR_PTR(rc);
>>  
>> +	rc = sysfs_create_group(&dport_dev->kobj, &cxl_rcrb_addr_group);
>> +	if (rc)
>> +		dev_dbg(dport_dev, "Couldn't create cxl_rcrb_addr group: %d\n",
>> +			rc);
> 
> Is there any way to create this with an attribute group that the sysfs
> infrastructure adds automatically?  I'm not suggesting you have a race
> condition here, but using the sysfs infrastructure avoids a lot of
> potential problems.
> 

I would need to look into it more. I did it this way because I wasn't sure
there was a way to set it up statically since the dport_dev can match a
couple of different device types. After looking at Dan's comments I will
probably move away from making this file altogether and move the functionality
under sysfs/debug/cxl.

> Bjorn

