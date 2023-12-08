Return-Path: <linux-acpi+bounces-2235-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 548CC80A939
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 17:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89F21F2101A
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B06438DE6
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="taR1rxRj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7640910D8;
	Fri,  8 Dec 2023 08:22:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSD+/CiVEMyJqHMFKwyA4giVUjT+mZZWmerXJx5/d17zCDb72pyEHKGZ7QwTHJ2D5mMUlrdAvF1XCe6MDH95tknTSpteOVuZEbVjMbtQg/y0Ra1L1QfEAVIfHLDPKVs2wb2TIHr0k72drc77gQndziqfoFmZ8PROZfx8TpYHp8a7TEZrbDbr20rm4LVlE1L6Wol4LjG4wC6u/0EHnXuYmocqiXrzNX6o76xD/oE/hWBD2dS12FX/m8PQhLRgdeHo1F6dAupSQiZLrEihAS9rfSq4TLzMVmiSj7czUld/Y4a+jinkE+0bRr1ovFbvxIy1htuQBYYNR4HPusjU9ZJAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxOvxGB7sRZcBL/FaPQyCf2RCiMoW8hcupAn4FNPT54=;
 b=ZdL+1n05jOpffMXSaQkEAy66E5VuyWI1rcvzAslLkvu2UGWDzT8coF9IGM3GqMsPseegKVHq4oJl7D6SDZg0F7XK8ttic3CAuNE1LnZQ2TpFs7sYFNjiGGS0Q/BoQNqjp5+4of3MCczUh+QmP9kAiQlDrxBwdsudHUWjvJio5mfNgzgWXltGmMrIMeI1D5lPMVT1yvINBG7ToMePCgDzcVZOkREbmZ3qsHwk26zW2ltEPf7zbXH+X+P1xDz8tCwGDocXfz0Lbxrj6B9hgIrcw7NAqxTRR4oXQdHWOyei9GZoQeraACnntgWOzMZyqYbc3o9w0oqfTqCa817Pz+sjYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxOvxGB7sRZcBL/FaPQyCf2RCiMoW8hcupAn4FNPT54=;
 b=taR1rxRjnB7Ii0LulKEMr42sie5AEV29EvzouXgENDfFdrLAUPOo+w2kfqVMMwFqjTcR4OvPTlJhpOdHa7+Q8LUuRUagp1C/squ+BNbTs6R48qkRsksCkZRtu8O8ZZmN0fsUUGBXoZ6W0vzYy0otxL6g8gZuXlx89tMQ3IEJVc8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3268.namprd12.prod.outlook.com (2603:10b6:408:6c::18)
 by SA0PR12MB4525.namprd12.prod.outlook.com (2603:10b6:806:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 16:22:28 +0000
Received: from BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::ff1a:dd7c:4c93:d8bf]) by BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::ff1a:dd7c:4c93:d8bf%7]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 16:22:28 +0000
Message-ID: <634ead4f-f87c-439f-a685-f7c1dc5527d1@amd.com>
Date: Fri, 8 Dec 2023 10:22:26 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] cxl/port, EINJ: Add CXL EINJ callback functions
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 rafael@kernel.org
Cc: yazen.ghannam@amd.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20231128160656.166609-1-Benjamin.Cheatham@amd.com>
 <20231128160656.166609-5-Benjamin.Cheatham@amd.com>
 <65725d405abf3_45e01294f2@dwillia2-xfh.jf.intel.com.notmuch>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <65725d405abf3_45e01294f2@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0068.namprd04.prod.outlook.com
 (2603:10b6:408:ea::13) To BN8PR12MB3268.namprd12.prod.outlook.com
 (2603:10b6:408:6c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3268:EE_|SA0PR12MB4525:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a1f29c-3c8c-4575-acfc-08dbf809df0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WEl5piuuHNs7jFGXTE7uknWdhwdtTl0IZqUhbe2EjBFMP4vSMH2HmgwiXvSgPOBRrtTpNl98drSz1DSdbC9E1IkJRc80xn/EMVriWBQR79X1TxnlcHmRgQ8/yjeFvg0ks/yWcUk68qW5NDRpmTLrAz9uU0/rQD+E7BY6Emp3eldmHNUkKK08rhaByZuXsQdCj/tDYmHmcm4CBr7/VBE1gjhZMUlgkSmHzspWGlA46auAwegZQ6HiWvMjr5CAcraiztU0MvLvPQI0ojtGMw7qb2tQNzYzcJYKi7hosVJmp/tzfqPyUSC+o+/ttQ+A7uqf/gbor75dzU2Ha0IpE3ZGvnhayQhFIP8Ck5acMUo2hq9T9QBFX23tnwKPlr3lr6NK9PwpoXv08HeFk93MyImkjpi1nQEwc7+FQXyEMW2ep/ue4Xp9hCXplO7j7eFdC6bphiNgrx3ux4ltQWrcT020G6KFQrUeBB1ZoLdTk1BvAnbyzt/96rBTfA7fZMz0erRk1KPPgg90cHCAXYvXBX5hTIjG2EG5V6tmtZ/ZfSuNcL8J66TtHQ2TSz7ji+XrfYrRvR77UOBFVHNIKor9Hm/od4U/cZ7xEVOH8d/EgwynTcidduWBe0rlPhXVo4POIK9htPuCSuJ8UPBfC/ug7ZwYsg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3268.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(31686004)(26005)(6506007)(6512007)(53546011)(2616005)(38100700002)(86362001)(31696002)(36756003)(2906002)(8936002)(478600001)(7416002)(5660300002)(41300700001)(8676002)(4326008)(83380400001)(6486002)(66946007)(66476007)(316002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmZoenVQUG05YURxU1lGNWk2ZVFDMW9Ibk9TTVkyV3J5UGpqcXBuNmorMTd6?=
 =?utf-8?B?Tk5KZ1B6YVE2TllWZVQ3bzlvR0tHZlNRbUQwQWo3VDRmL1VIZnlCOHF4eUkv?=
 =?utf-8?B?UldzRVFHTXcvdTlIUEI5bGRvRysyTzV2ZkdGSkljOW13QWxDNzBaQ0RIRW11?=
 =?utf-8?B?WFozZGQxdnFOMFJxeExOZXpycythUHlGeEEyNUJEMDJkakdCcFUwWHVkRWFC?=
 =?utf-8?B?Y1VwVlQ4dnM3Tk9BakRPQStBQzNxd2dqMUxabm5jeGVjRjgyZlJZNFBOQTN4?=
 =?utf-8?B?aWxtVHRJbGd5eUhBUmRtVkVQVFAxNWFzdzZrTmZCanFhQ3RDS3N5aFhEWEd1?=
 =?utf-8?B?dUNEdVVSY09KbUx4azUyVWlGY3VETm81ZlJWVEx1MG4xcTh5ZEJEMGxmYnp5?=
 =?utf-8?B?RWZWd1NkSHY5SUQ4TWgwS0NnWmovOVBXYXluSVRMKzM2ZW8wQjlkZVllS2Ro?=
 =?utf-8?B?TCtMcTBuaHczNTA0elE0NCtUN3FiYndGcXF1bk50RVYxcm0xNDdhSjhrKytZ?=
 =?utf-8?B?ODl0bS9LVFRaOTRDUmoyYmxoanJkbU4xN2lxN2FsTjdhcm9qRGdYTzdQWGxN?=
 =?utf-8?B?ZGdXb243YUt0cWtlSXRseG1SbVVLaUV4Q2JFZmlIbVhZRmt6c1kxYk9reGov?=
 =?utf-8?B?SjVDcXBtNW1CRWF3dXBnOWxWV1JPdncxT0JUTEJWeGhuMGtkNHlxaTJGSERw?=
 =?utf-8?B?YnNCVmJaNnZOSlNFVjB0UXh4R3dsMC9oeCtMQWl2d1BzcE9uMG9CRVRMTkJh?=
 =?utf-8?B?bkRmMzk5TXYzY0NqUnFyd1ZVaGZPN2dZNU00WFBBczNONitrb0lRTE1LVFc1?=
 =?utf-8?B?Y01yQ3M1aS82V04yZWQ5RlNieDJFTE5HeGhFRUo4VmRwVldka0hIU1kwSHJp?=
 =?utf-8?B?ejhiTzc4L0pvVTJvZkNMWDV1eldNRmZoWCt2blgya0NWUFdBbldNN0kxYkNS?=
 =?utf-8?B?b3lSaTByQllWcjdmdGpKUWpGVWcvWmFjN1dYME9pSFVCNGNWN1lFRFFGNnFk?=
 =?utf-8?B?dmZLd0tYRmRZamdoNmhYQ0J2NHc5TWgvM0pIa0JIbmRmL01xQk13d1VMeGtz?=
 =?utf-8?B?dkZPZGx3M2g1anRBaGwyZUI1eVAxQ1pLc0VhTzVQQy96WVF1dlcyeS9obVZi?=
 =?utf-8?B?anBYZmZPcVYyNlZIc0g2UU9lMmUrTGVvb3duaDRDR2dTeGFXWHBJRE83U1hS?=
 =?utf-8?B?SmtMdVprZmRVNk9TckhpU1V5eGZFQkVRY1NXOG1zRjcySHBqUEIxUGdzczZL?=
 =?utf-8?B?WC9DTUw1ZjlMSUNHenN1M0E0NXluM1Z3bzUxek12YWhDUENNMUZUd2s0Mmo4?=
 =?utf-8?B?UDUvMFBnMUpVQ1M0SjlySUJZRWxmMC8zMmkrRHd5MFRDZ2VnM1pieDVNM0pM?=
 =?utf-8?B?b1FURjhYcXlrYUNMS0hHTm1ib0NrZDU0NTZIYVphZHp6Slh5bXdhNW5DbTRl?=
 =?utf-8?B?eGx3d1E5R2MwTms0NnhYSG9GR2Y4cWw0UFZRcnFnaTZkU0JML3krQXpycWIv?=
 =?utf-8?B?b3k0ZVNjTGErU1ZiNlRmdVZRMFVKb1hNYVJkdTBraUhFR3VETGd1eG9hVmY5?=
 =?utf-8?B?MXZjWUJmTmtteExMZVdlSnBhRERLNjgvVElvWklEbHNHWGZIb1I5ekk5VjQz?=
 =?utf-8?B?MnVEeUZ0WUVySFVRc2I0Q1pMZHNxYmh3WHZ4a3hGb25QczYyZ1k3amtPRCs1?=
 =?utf-8?B?dDBmclJGd0E5NGtjNnFsYkIxUkwzU0lwb21hWHFsc3RneE44SmZXVFJoN2Rv?=
 =?utf-8?B?Q1k2aGJSVU5Kc1I4ME5XOFpHVGh0MUZWYW9PaHY3T243Sk41YXJGR3kyOHdp?=
 =?utf-8?B?MnpndzdNeWtLcEdaSjBEMEdJZnBIVnI5K1hxNDJqUXBYbjZ0SzdoNU5SVU5X?=
 =?utf-8?B?SHo3ckZUYXp5dTlyajhuOThIQ2k5b2pHSGQ1aW9rR2tOYTQ4aTRmaEpuTU03?=
 =?utf-8?B?NEV1a0I3cEIwZnk5VnhhUldqWnlIbk96cjBwQllwM1RNUDdOUnBUS1FTUUN6?=
 =?utf-8?B?dk00V1JMbDhOcXlRTU1lRHdlS29rcEc1OUFGMUp5YmJiTGJ3TW1XdmJPa29H?=
 =?utf-8?B?VTkwRmdYOUVlQnhyQ2UxQ2VOUW9qS3AxaGEwZmpHaDFCdjR5WjdMWGZHa0pl?=
 =?utf-8?Q?Cq1oUYc1EHIgNUk4q198cQG9f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a1f29c-3c8c-4575-acfc-08dbf809df0d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3268.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 16:22:28.4875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 298TcHD7+wV5eSsKEYPNkTMIzqKU+DQORhZdJmiF2AQf36jk9hA5i8MQtURfO00qvAks8jpiGv6bKJ6So9SYpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4525



On 12/7/23 6:03 PM, Dan Williams wrote:
> Ben Cheatham wrote:
>> Add functions to the EINJ module to be used in the CXL module for CXL
>> protocol error injection. The callbacks implement the einj_types and
>> einj_inject files under /sys/kernel/debug/cxl/portX/dportY. These two
>> files work in the same way as the available_error_types and error_inject
>> files under /sys/kernel/debug/apei/einj, but only for CXL error types.
>> If the dport is enumerated in RCH (CXL 1.1) mode, a CXL 1.1 error is
>> injected into the dport; a CXL 2.0 error is injected otherwise.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> ---
>>  drivers/acpi/apei/Kconfig |   3 ++
>>  drivers/acpi/apei/einj.c  | 105 ++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 108 insertions(+)
>>
>> diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
>> index 6b18f8bc7be3..100c27beb581 100644
>> --- a/drivers/acpi/apei/Kconfig
>> +++ b/drivers/acpi/apei/Kconfig
>> @@ -11,6 +11,9 @@ config ACPI_APEI
>>  	select PSTORE
>>  	select UEFI_CPER
>>  	depends on HAVE_ACPI_APEI
>> +	imply CXL_BUS
>> +	imply CXL_ACPI
>> +	imply CXL_PORT
> 
> This goes away with the CONFIG_CXL_EINJ scheme proposed on patch1.
> 
>>  	help
>>  	  APEI allows to report errors (for example from the chipset)
>>  	  to the operating system. This improves NMI handling
>> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
>> index 330329ac2f1f..98d5e6d60a02 100644
>> --- a/drivers/acpi/apei/einj.c
>> +++ b/drivers/acpi/apei/einj.c
>> @@ -21,9 +21,11 @@
>>  #include <linux/nmi.h>
>>  #include <linux/delay.h>
>>  #include <linux/mm.h>
>> +#include <linux/pci.h>
>>  #include <asm/unaligned.h>
>>  
>>  #include "apei-internal.h"
>> +#include "../../cxl/cxl.h"
> 
> EINJ has no business knowing all of the details in cxl.h. In fact all
> EINJ cares about is dport->dport_dev and dport->rch. I think just add
> those to the calling convention, see below:
> 
>>  #undef pr_fmt
>>  #define pr_fmt(fmt) "EINJ: " fmt
>> @@ -627,6 +629,25 @@ static int available_error_type_show(struct seq_file *m, void *v)
>>  
>>  DEFINE_SHOW_ATTRIBUTE(available_error_type);
>>  
>> +static int cxl_einj_available_error_type(struct seq_file *m, void *v)
>> +{
>> +	int cxl_err, rc;
>> +	u32 available_error_type = 0;
>> +
>> +	rc = einj_get_available_error_type(&available_error_type);
>> +	if (rc)
>> +		return rc;
>> +
>> +	for (int pos = 0; pos < ARRAY_SIZE(einj_cxl_error_type_string); pos++) {
>> +		cxl_err = ACPI_EINJ_CXL_CACHE_CORRECTABLE << pos;
>> +
>> +		if (available_error_type & cxl_err)
>> +			seq_puts(m, einj_cxl_error_type_string[pos]);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int validate_error_type(u64 type)
>>  {
>>  	u32 tval, vendor, available_error_type = 0;
>> @@ -657,6 +678,68 @@ static int validate_error_type(u64 type)
>>  	return 0;
>>  }
>>  
>> +static int cxl_dport_get_sbdf(struct cxl_dport *dport, u64 *sbdf)
>> +{
>> +	struct pci_dev *pdev;
>> +	struct pci_bus *pbus;
>> +	struct pci_host_bridge *bridge;
>> +	u64 seg = 0, bus;
>> +
>> +	if (!dev_is_pci(dport->dport_dev))
>> +		return -EINVAL;
>> +
>> +	pdev = to_pci_dev(dport->dport_dev);
>> +	pbus = pdev->bus;
>> +	bridge = pci_find_host_bridge(pbus);
>> +
>> +	if (!bridge)
>> +		return -ENODEV;
>> +
>> +	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
>> +		seg = bridge->domain_nr << 24;
>> +
>> +	bus = pbus->number << 16;
>> +	*sbdf = seg | bus | pdev->devfn;
>> +
>> +	return 0;
>> +}
>> +
>> +static int cxl_einj_inject_error(struct cxl_dport *dport, u64 type)
> 
> If you split this into cxl_einj_inject_error() and
> cxl_einj_inject_rch_error() with following prototypes:
> 
> static int cxl_einj_inject_error(struct pci_dev *dport_dev, u64 type)
> static int cxl_einj_inject_rch_error(u64 rcrb, u64 type)
> 
> ...then you don't need any of the cxl.h definitions. The dev_is_pci()
> and rch determination details can remain private to CXL.
> 

Good suggestion. Will do!

Thanks,
Ben

>> +{
>> +	u64 param1 = 0, param2 = 0, param4 = 0;
>> +	u32 flags;
>> +	int rc;
>> +
>> +	/* Only CXL error types can be specified */
>> +	if (type & ~CXL_ERROR_MASK || (type & ACPI5_VENDOR_BIT))
>> +		return -EINVAL;
>> +
>> +	rc = validate_error_type(type);
>> +	if (rc)
>> +		return rc;
>> +
>> +	/*
>> +	 * If dport is in restricted mode, inject a CXL 1.1 error,
>> +	 * otherwise inject a CXL 2.0 error
>> +	 */
>> +	if (dport->rch) {
>> +		if (dport->rcrb.base == CXL_RESOURCE_NONE)
>> +			return -EINVAL;
>> +
>> +		param1 = (u64) dport->rcrb.base;
>> +		param2 = 0xfffffffffffff000;
>> +		flags = 0x2;
>> +	} else {
>> +		rc = cxl_dport_get_sbdf(dport, &param4);
>> +		if (rc)
>> +			return rc;
>> +
>> +		flags = 0x4;
>> +	}
>> +
>> +	return einj_error_inject(type, flags, param1, param2, 0, param4);
>> +}
>> +
>>  static int error_type_get(void *data, u64 *val)
>>  {
>>  	*val = error_type;
>> @@ -668,6 +751,7 @@ static int error_type_set(void *data, u64 val)
>>  {
>>  	int rc;
>>  
>> +	/* CXL error types have to be injected from cxl debugfs */
>>  	if (val & CXL_ERROR_MASK && !(val & ACPI5_VENDOR_BIT))
>>  		return -EINVAL;
>>  
>> @@ -714,6 +798,7 @@ static int __init einj_init(void)
>>  {
>>  	int rc;
>>  	acpi_status status;
>> +	struct cxl_einj_ops cxl_ops;
>>  	struct apei_exec_context ctx;
>>  
>>  	if (acpi_disabled) {
>> @@ -793,6 +878,15 @@ static int __init einj_init(void)
>>  				   einj_debug_dir, &vendor_flags);
>>  	}
>>  
>> +	if (IS_REACHABLE(CONFIG_CXL_ACPI) || IS_REACHABLE(CONFIG_CXL_PORT)) {
>> +		cxl_ops = (struct cxl_einj_ops) {
>> +			.einj_type = cxl_einj_available_error_type,
>> +			.einj_inject = cxl_einj_inject_error,
>> +		};
>> +
>> +		cxl_einj_set_ops_cbs(&cxl_ops);
>> +	}
> 
> This goes away with the new Kconfig dependency scheme.
> 
>> +
>>  	pr_info("Error INJection is initialized.\n");
>>  
>>  	return 0;
>> @@ -810,8 +904,18 @@ static int __init einj_init(void)
>>  
>>  static void __exit einj_exit(void)
>>  {
>> +	struct cxl_einj_ops cxl_ops;
>>  	struct apei_exec_context ctx;
>>  
>> +	if (IS_REACHABLE(CONFIG_CXL_ACPI) || IS_REACHABLE(CONFIG_CXL_PORT)) {
>> +		cxl_ops = (struct cxl_einj_ops) {
>> +			.einj_type = NULL,
>> +			.einj_inject = NULL,
>> +		};
>> +
>> +		cxl_einj_set_ops_cbs(&cxl_ops);
>> +	}
>> +
>>  	if (einj_param) {
>>  		acpi_size size = (acpi5) ?
>>  			sizeof(struct set_error_type_with_address) :
>> @@ -832,4 +936,5 @@ module_exit(einj_exit);
>>  
>>  MODULE_AUTHOR("Huang Ying");
>>  MODULE_DESCRIPTION("APEI Error INJection support");
>> +MODULE_IMPORT_NS(CXL);
> 
> EINJ never references a CXL symbol in the new proposed scheme.

