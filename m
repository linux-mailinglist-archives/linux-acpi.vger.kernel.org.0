Return-Path: <linux-acpi+bounces-224-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2048F7B0A2E
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 18:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C7BDC281701
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8153C699
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:32:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA201170B
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 15:31:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA17F121;
	Wed, 27 Sep 2023 08:31:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxFMtYFaNq6Vah2GtbO0i1xaPrdMj/sgf+Y2KpoyfPZnHa2/e18bENO3bsGULMFzVIIpDb8Lw9WQqimOpDPI9KSzjeH7JpUdirpUObNLo61ufuJVANO1rnyDCixdb2swEPVFfF4q6pqUvkP4ytegsWN12fdsGgy0whAZuxGsInb2L0HZNn356s8xF3HnUXwLuK1fAUkhlkGGh4Dn9oLWM958JafkjGRg/KqGh1GR3AU+QKqYaGQWLl0HL/RnjSHnzEx0R+9bHwzYotZkDwwOjAK0b3satAFGPC4amSI9kjKX7rt6C6sz77FwMGAsB5pVKTxJ18c2YdzfD7hGvgJFMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqzxRfQay3tv2Y8TKsMIdeUfmEsymQuO0Htnr0rOOXM=;
 b=VR05vYUimgDciEuY3snKOc/PdurRXPGTbDV2kKd1aSUdFnCefjzcmEXkq+i/alTHVQIzOgxqdoMLbUB4mnH4Y6lsZNnEcVF8CDTHYZQTgRB1H7Ytjxue6fXIdTicxwLhtoyr5nA4cwoSykppRBwujQHr6JineeeXGOVynX2e0N51Ee3FVd0LEPn+yzlR+O/U1SLH/TetMDjQz/L4tOGkbs/mzTu5TjMkTiYtXd3McQLUDqo+LKFmzS1XslAUSkpwhhp0gOX1LOCPkZeJkEY+LepGTXQB/cCWC1kCF/rSNqa9IVONH6v3vWySHEjTJ4j4PfSqloIGgTX3Bhf6LwrBVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqzxRfQay3tv2Y8TKsMIdeUfmEsymQuO0Htnr0rOOXM=;
 b=b5muqaYoCMigWsYKMfUl6RdMJOA2WUGlKwrJNqVAw7sjo8CzZ1sR5014kgpv+gYxdKyVm+xaHTCW2rSUFMXIimkuWiK6NXtGDrQKtTS2ZwwY8k3DeH8BNhUxF9BVT63oucssC4G4T90Isk5AvZ1Y4+uE9GSTOFCHYQR+MpVqaCo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3268.namprd12.prod.outlook.com (2603:10b6:408:6c::18)
 by SN7PR12MB7417.namprd12.prod.outlook.com (2603:10b6:806:2a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 15:31:19 +0000
Received: from BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::6423:58db:9384:4031]) by BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::6423:58db:9384:4031%6]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 15:31:19 +0000
Message-ID: <0ee93e94-8a1a-8b4e-43ed-725a2fc9510a@amd.com>
Date: Wed, 27 Sep 2023 10:31:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 2/3] ACPI, APEI, EINJ: Add CXL 1.1 EINJ error type
 support
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: rafael@kernel.org, dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, bhelgaas@google.com, yazen.ghannam@amd.com
References: <20230926202249.GA425563@bhelgaas>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20230926202249.GA425563@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0028.namprd11.prod.outlook.com
 (2603:10b6:5:190::41) To BN8PR12MB3268.namprd12.prod.outlook.com
 (2603:10b6:408:6c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3268:EE_|SN7PR12MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 2297d9f2-25d7-4544-6e52-08dbbf6ecbf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y3I0kUStBTSXGZMVGLX2KPINheQF3o1JpxfLbWTr48IrQE2WUcAbCNEx4eRE6lVwEpeDJJRq/a35vZDpDvqZESv/Fsi4mad13z5aFDETY2rhXF/luGYlSMtUMrRGmFqICzUhAxySWbC2+P+JhK72vrO4cQSEyEtTSiUaH+ho59CVkvjtRYrjbV86iyGDutXdZs8COjmErZZH3zdYmIs8yKrvLukuNAA089lYArz2yamZAi3D3ao7hjfVN8kP8wqNIEjpNAMIgSRca84WSb7ykcrUpodk1pO3f0WkqFpjxuQBqxC/WjyWkMbAtwAaszn5GD+bJMB8Xdv/vSeRX5zknWbGA78T/Sb1qgWoz+WjyWwyFsMOUjmWNHVAtO+Uip1Ps7Bj3qHgFHch65Qe9P5KvoZYIp/Hg+OsyG7uzW+h/PaU5T+dIYBPU36x2+zyl+SX2UweV9x0EXpjuFQkzKHKwVN0jWrk39Siy9gVHSD6mOd1x+Ut6AuWbRBTboSc2iO5QULCIT3tAm3+W0ciruFv76rXtMQ5zmKSQADHK5yxfRqtDHJeJRhopl/lbzlB0N0NapNB9fNLkWvdf6f8FK/v3vKYX9QP9UA3ImnCzleI5YDiuv7FKVGw2vdJ3eOJbV2Bi2bHt2vCUtEjGyUjbXcs4w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3268.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(186009)(1800799009)(451199024)(316002)(5660300002)(8936002)(4326008)(41300700001)(8676002)(66476007)(66556008)(6916009)(31686004)(66946007)(2906002)(31696002)(53546011)(2616005)(6512007)(6506007)(36756003)(478600001)(6486002)(86362001)(26005)(38100700002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUxOM1ZvVU1KZmVmTjBzODB1ajVDOFp0TkxJOFFkUnVPUDA5U2lMUjI5V1I1?=
 =?utf-8?B?cjBaalF4TEJGQ015QUNIbWxZQ1VJTlBrL25kbDlsYWovYzM4WEllczY0TDUv?=
 =?utf-8?B?dSs0V3RCdS9sek9yWUxBRHBIRFBhY2F0djJZVkVsZFRGaTEzaU1UTitSNVFo?=
 =?utf-8?B?aGpRdXhrMXBDeDYyQ1l2M2dBOTZUWWJsN2pyS3ZGbVRhMUFRUitRSVlyZ0p0?=
 =?utf-8?B?Wmw1SGFLQjRVbTBJVmlqbWkwNjhTUGdxSUwvWEt4bVJVVnYzdVJ2cllHb0xG?=
 =?utf-8?B?UGJFRklBWWRnQjVUbnFFQnU4ZVlJTTJ2TjI5WUxiZkg4SGRZbFBCN2JBVkxG?=
 =?utf-8?B?VStZdDdNQVRDSTl3WnBNL0VuZXgvZnVuTUwvWjkxeUJXYkJjd3B2MEJ0Rmty?=
 =?utf-8?B?a2YrYTVjbFZwRk9lcWtVT1FGSk9ibFpUcjVUUTdhc3RGcEt4YWN0MEZ3ajBZ?=
 =?utf-8?B?WWV2cEQxUG9aeTlBeWZjU0VtN081OGYwWGFxSjlkSEg1djZMM05oa25pSDhY?=
 =?utf-8?B?SUdoZGl4SlYvd2JUcFFxUU9GdXk5OTcxUUJqTndSVC9JcTZmcWRkU3kxNDll?=
 =?utf-8?B?Q1RHRStqWEdDaVRTeXh0RE8zN0VRNWpoaUcxZlFDZkIxbGVHTWlSWmJRUWsz?=
 =?utf-8?B?eXVwVnp4ZkN3REVmY05McEprL09aaHlYdzN1bVJwS29yWElUd0NTbzRCclR6?=
 =?utf-8?B?cEYyeSt2VmkyOURyRWtxNmNnMkhFVk5oTklXZmxLbVo2eVdWT2dRUjVIckVy?=
 =?utf-8?B?Z1VlRW0zYnlXSmJhS0FiYlhTb0tPejZ5d3BnWTBmZzJaRnFwRnhuSVhVRHZN?=
 =?utf-8?B?dWtNMmNkTEVPajFUeEJuT1VpSS9QS1NzOUhJNDJRWWROYUkrK1FZenA5YTU2?=
 =?utf-8?B?OGtENVJyaFMwOWhUNUFZRHM5a3V5bitBZ1NRVWgvemNOTGxERW8zSzNWVnh6?=
 =?utf-8?B?OUMxL2drclREUFFjNHNGejM4SVZUMDhDYUY2UldlY0ptN2VNV05VVWtQT2xF?=
 =?utf-8?B?TTRLaVVtang3bHAwQ09lUkExaWplbjN3OWpEWmZZS0VlWFoxdHVyRkJ0dlJ6?=
 =?utf-8?B?cFRYTXVBUU1uQ054N0RoVXhIQjk5d0dmM3cyeWtIbXNhRzhtYVFzcVBiNS9i?=
 =?utf-8?B?djBEZXFZMitjYUF3cWI1N2lKaGNTQlZNTDB1YWhWbm10dVJLK3ZqSjVUbkR6?=
 =?utf-8?B?NFJyN3BGUC95TVpEYlFtSksrT0Q1dmRpU0crSm5UNlhZTmtTQklWWVVUUWNo?=
 =?utf-8?B?U0d3ZlprTTJyeVBvWWdDdDZNRmZhUm5pZzdxVlBrZ29RdlllQlQ0Y0p0S2tZ?=
 =?utf-8?B?cEtBM0RxS044dXdvSHhhRytqakhtZkVOZ1RHREhTZWI3bDFKRUEwU05KbDFG?=
 =?utf-8?B?TURmZmExamwyUVQ1VFVVeHdKN2h6U2RxWTJncWxZa0kzc3Z3MWlVRXAyUzZX?=
 =?utf-8?B?bm53bVRCSlp3ZlV4UEZMZVFBVVVIb3dUSlRPdnEwY284S2dVaUdURmtKMnBv?=
 =?utf-8?B?SGUzQlUzdk9qZ2lTWUlYQm56U3Q4Tm9TNUpPamsxVWhaTFNCT3JURkJTNG1m?=
 =?utf-8?B?MDZYaW94WFF0WThLeHBGQWw2WnlMVzloc2V5bkJKMXNyTnBKRHh5TUlhWFJW?=
 =?utf-8?B?QjZnNlB6eGVMZEpRMDdscnVDNzRNemk1TmowcTZjL0ZtNjltSy9RQUJUczNp?=
 =?utf-8?B?QjBoMjFNVXhzM1hLMlV2NU1DbWxIZzd5QnpJSEwwbmZtUVVYTmU3ZjdpNHhC?=
 =?utf-8?B?S01sYUdoMzZiNnRpUGlndFFPVWZadSsyY2UyeGNiTVpiZnFBR29RSC9uNGRi?=
 =?utf-8?B?UXJ0U2k2aXVTYXI2Wm1sOThIL1h3MTYwWXNSY2IzRkN0azQ2VEZFRVpCZ0hu?=
 =?utf-8?B?QmVaN3lMVHdXb2QvTHNONEF0aDFtOC9xK0xUVnZxYnJaVlhBa254cHdjOU1o?=
 =?utf-8?B?dTQ2VHZ1dmtUbkNza25RZXFlMVNMbDVtK1U1bHgrQkZ0TFB3RW5hcDJRNVVF?=
 =?utf-8?B?RVo2eDYwVDFBNTRzWWJodEwvekk5ZENPdXdGdDdQWGM0REJ5VXJ2U21OVm9o?=
 =?utf-8?B?NFM5L0JWSjBXNnNtd016OE5qbWZZbjJ3cFhXbmZDTHd4RXU4aGhSSFFxRHpN?=
 =?utf-8?Q?P/i+q/ASzL6uiiUHGhXSDJjJn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2297d9f2-25d7-4544-6e52-08dbbf6ecbf2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3268.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:31:19.2988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UutvVJqULS5Y2Ln6bU050UKK1W1ui7Tuanl0huYCvhALSjUHJH300YfZr3ZQJmLClEK9SffvAnhreyFzwBRceA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7417
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/26/23 3:22 PM, Bjorn Helgaas wrote:
> On Mon, Sep 25, 2023 at 03:01:26PM -0500, Ben Cheatham wrote:
>> Add support for CXL EINJ error types for CXL 1.1 hosts added in ACPI
>> v6.5. Because these error types target memory-mapped CXL 1.1 compliant
>> downstream ports and not physical (normal/persistent) memory, these
>> error types are not currently  allowed through the memory range
>> validation done by the EINJ driver.
>>
>> The MMIO address of a CXL 1.1 downstream port can be found in the
>> cxl_rcrb_addr file in the corresponding dport directory under
>> /sys/bus/cxl/devices/portX. CXL 1.1 error types follow the same
>> procedure as a memory error type, but with param1 set to the
>> downstream port MMIO address.
>>
>> Example usage:
>> $ cd /sys/kernel/debug/apei/einj
>> $ cat available_error_type
>>     0x00000008      Memory Correctable
>>     0x00000010      Memory Uncorrectable non-fatal
>>     0x00000020      Memory Uncorrectable fatal
>>     0x00000040      PCI Express Correctable
>>     0x00000080      PCI Express Uncorrectable non-fatal
>>     0x00000100      PCI Express Uncorrectable fatal
>>     0x00008000      CXL.mem Protocol Correctable
>>     0x00020000      CXL.mem Protocol Uncorrectable fatal
>> $ echo 0x8000 > error_type
>> $ echo 0xfffffffffffff000 > param2
>> $ echo 0x2 > flags
>> $ cat /sys/bus/cxl/devices/portX/dportY/cxl_rcrb_addr
>> 0xb2f00000
>> $ echo 0xb2f00000 > param1
> 
> It seems sort of unpleasant to expose the physical base address of the
> RCRB.  Is there any way to use a device address or other logical
> identifier instead and keep the actual MMIO address internal?  E.g., a
> PCI device has a <domain>:<bus>:<device>.<function> address.  I assume
> CXL addresses would look similar?
> 

I have the MMIO address of the dport exposed here because the ACPI spec
says that the address is expected for CXL 1.1 errors and I wanted to match
the spec. For CXL 2.0 errors the SBDF is expected as you described.

>> $ echo 1 > error_inject
>> ...
> 
>> +static int is_valid_cxl_addr(u64 addr)
> 
> Maybe the function name should include a hint that this should be an
> RCRB address?  But I don't claim to know the CXL architecture or
> nomenclature.
> 

Good point, if I keep this function in v6 I'll make the name more
descriptive.

> Bjorn

