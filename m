Return-Path: <linux-acpi+bounces-3336-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D90F84FEE6
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Feb 2024 22:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2552812F5
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Feb 2024 21:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA3317729;
	Fri,  9 Feb 2024 21:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4kHaCx0A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1965214F6C;
	Fri,  9 Feb 2024 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707514246; cv=fail; b=B47ksrvDZ5NBb9jgfo0CgdkzE/vtZcMyAnHASUCG43FC75RFPeN9UEU0yWIBrjkCbnHZk5VMDcmCSICkSR3YttwL38/9KQH/6g5IQkooywh3elJ9lnlTqg2y9ajn70dG0QDLHJZghB1MFF4dDNgcNqRJv4btX+hg3hUoqLAOroc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707514246; c=relaxed/simple;
	bh=p+PKDrT/bEuMiklcllbsVj2tA21emmbJtmudGQ8tHhM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jmeVFzcPMMzp2OH3kjaI6nHgcEA5S9vw2xP6mWE+gyMIGzN7ragxHyZNFt1E4tinzhe14QIClrD5IMcvm+9jqPG/SIwfTZIX1e/KX+Pi3DfK+ejMSLV3BbuYWBKj4kZckh3ZHHvdxnlQJYQ58LgAJCSVJ4/EYEB00UlAwTvh2LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4kHaCx0A; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ll9GCsJIFrEc+GRcADEwPVwGzulfB3wYyx+FdZJkVjaag5Lwjobd0+wR7zuX99VUbz57p2FsjCBd5CbC1E68P6f/B24vuZN7Ux4CTWuiQpXzUV2TsC1gAcljtB4hird2f97YqhSjnThiYY6YJLrP08a7Y7OBKZeTMprnk1+JLhaewwYraeU6PvxPE5Ld8LEQVT1+YmA454HeYf9IQHE4TZwdpHaZMrgFdNRPFiKJ06fzFmAUxu3JPXQLdvJH13oy1QqbJ8LYe46iEGAQVxl8jtbRy5hdIG/D/CWg/fwmOqUFzbL0V8ZUq8B03O9N3jkY3sii6I9Oo5G6qNEfEivTwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpFJk22Oi/+U3T9s12L9zZawy/rouDFzEyJSKn6ZsH0=;
 b=gy3AJ401gRAwl7tf1VcFxzK2NxdBvykMfDkpVuy7ieEByIHGMVuFhPD63+wZU2pTaCW1k040qUeVyezAjfgVBMLOjgKoZ+Sf4wd0aEkDFKLX6EyYZyYuAIPqR7oD2i/pBs/4AU9geUTcYQTv0m9q1XcoYF6wajJwP1qttzi2P7keW4aAiPWgJbfMXDbwrbKeZV40iMposji9MEidr18hMdy8A/UmXpbxdTcsBiWOTKwBBcQ3HjhETpbC0nogRXqnh/w2eEpA2fMcdBqYR50GOau5ou91wekqGTKZm+jg/JB9iBpa+5SofsN/m7s7aPnwM4GiQpgTMSrr5xRmcR9dew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpFJk22Oi/+U3T9s12L9zZawy/rouDFzEyJSKn6ZsH0=;
 b=4kHaCx0ABp9KCJxj+gkue+1LSfzKwpDcIWCOiY0b78yeuvlvLihiccF3n3up8jDwMViD4YnypIBOwDNrE4nPXI5+4uLCQDJErGFBZ9a34AIt64fU9JFjqKNic1WP/z2frjQCEii9DZ9cHO92ZHZR3XgljbxTfwqRyTsJ7//pc0E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Fri, 9 Feb
 2024 21:30:40 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::b21f:aced:8bae:a73d]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::b21f:aced:8bae:a73d%7]) with mapi id 15.20.7270.015; Fri, 9 Feb 2024
 21:30:40 +0000
Message-ID: <6cd90997-0dea-4dd6-ab8e-2630efaa6209@amd.com>
Date: Fri, 9 Feb 2024 15:30:26 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/4] cxl/core, EINJ: Add EINJ CXL debugfs files and
 EINJ helper functions
To: dan.j.williams@intel.com, dave@stogolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 rafael@kernel.org
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20240208200042.432958-1-Benjamin.Cheatham@amd.com>
 <20240208200042.432958-4-Benjamin.Cheatham@amd.com>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20240208200042.432958-4-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0085.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::28) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|IA1PR12MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 53525f3e-10a3-4615-78df-08dc29b65d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1qaIq4eVNacyC9yFR853AYuUPRDpcLqd/4LOQjLdSuLG+NHVXag9ZYeRan2KENNi/ylnMA/donZ56nAjvYqBo6U9awgjP07nO2btw6ireiuQijXBcyvxYf2U/ahbb0lTQpUkG5UPp8dC4bpXJp1GNUSqJN6BsO4oOb39iapdOYOE5qBUlRJWrT2YhW+wR0j/4fqDjRTyfHy4A74W0cDgKWAhXkePT61SWKezbBXeTuBHXXA01g3mfdj6CJms6p/ey12KFiwuHGQakjr0C051XMZUwmyNAZXCLV8B0qDAgFoDKijVpUuiWwwkGcA1iVP7eVs2CKDbC1aYSZtmRzY1dK5teVwuHKd6dYNzILw0t4btRYElpq4M9M5OjUT2M2T/dFdFj9qLtkptEv5N5kpzE00zWM8Ns0vw82T/AinvzasmSRPPOtouvn1FlHzllehIlsz9RKEJvU9PoiFsUU/hSaK7zpITkJ9O4tMAO/u/kBLaz3Hltx5SJVtxKRy6Tb342uGrlrjohNQdqC9IWgZNKS7ta7YYWSAnWEpGbbqW+cqtUMi3D5TmMPeC+BiTQ1zI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(4326008)(31686004)(2906002)(83380400001)(38100700002)(6666004)(6506007)(5660300002)(26005)(2616005)(6486002)(7416002)(316002)(31696002)(8676002)(66556008)(86362001)(66946007)(30864003)(6512007)(478600001)(66476007)(8936002)(53546011)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2RHbXVibkhUWVZiNUtnVHhDbllYOFNKUmI0Unc2amc5MURUM0x0bUpTQTBa?=
 =?utf-8?B?Qzc1SUxkK2FsMGExOFdQSHBoZzBHMFU0KzFWMU1TWVE1TlNvK0ZsL3hqeDVy?=
 =?utf-8?B?dFlWVUl2QlFzcVNSSFQzM21DL2xyN3ZQdm5QR2VGSWUxemVOS3RKRUJIRTkz?=
 =?utf-8?B?ajJFU1cwSldDcXdzeWgwTkl0b3BTZUttZW5saEpYOXVncnJXcnZ2SGtlOWtj?=
 =?utf-8?B?dTcvT1E5SVdGdWdIL3lUVlBENFNYK0NsOWtOWk5iUlViYmprRWIycDVUc3M1?=
 =?utf-8?B?cXZVM1RFeUxxR2o0Q3JlT0tLbzczWFFNaEVWUk5BMmFDRnI2cDBjSG5IbDV4?=
 =?utf-8?B?V1dmMTJrZ2M3MUdlaERqVEV0U3NWUmNMTHJ5cUJ6bm02UnFzbHQ5RmNHQ2Vp?=
 =?utf-8?B?NmV5RGpQWUhzeWREQWxoem92bzJhT0Z4cEtsL2FDVlMxS3c5ZE4weGhjL2J4?=
 =?utf-8?B?RWs2OXZGU1RTYmRsUXBGK1BTQ3hjcmlnN3lhZDllMDRFcXFRYnBCQklaV0h4?=
 =?utf-8?B?RnRrVG9SWjlLNzNrVGtLeG51SElaQ1p5Nk00cTZRRGl2LzJIOENVb1Q5L0s2?=
 =?utf-8?B?U29VZGlUblhoeFp0R1M4SWZ6TWFFKzdad2J0U0RhbHhMbnhrSmgwdHljSFZH?=
 =?utf-8?B?UjZJSDRrZVdpa2dpZHBMUko2K2pYWkxNWUJrQ3I2dzZFK3VhMktscDBGQXJq?=
 =?utf-8?B?aUd5MXh1dmc3ei9YejROejArUTZsTWFJa0VBMGYxanpWTUkzZWNjSjYzZGE2?=
 =?utf-8?B?M2wxZzJuTHlLRUZHS3NHTXRMc3E1N3VkNjhUK3dHNGhlVTE5Z2wyd0VOdVll?=
 =?utf-8?B?VzVmaUFCc09YVnloL0x1aHlYOXNBdSt5NVZ2M2laWFdUNlRHcEhlckRkdE1K?=
 =?utf-8?B?Z2tNWEppdmdsMnRYUFNVT1lhN2ErSFVZd2R2VDEvRmhid1F2Z3A1SHBNL1Q3?=
 =?utf-8?B?VmFmVEhiSUlSdHprMGlobFZUVktvY2FabUFpMk5aVmJ3aFB2RWpqRmVTQVpw?=
 =?utf-8?B?MVhOYWdYaWdGYkhSV1IreExjTzNZVDVjUVJIYVNhS0hTZnJFS0NzbEZXRTk0?=
 =?utf-8?B?cFJHcGNVWnRObUdmNnp5SUhDeGN6TnZUdDZFRFpFSTVaTDU4ZlVPdVpSemVZ?=
 =?utf-8?B?Z0ttN1ZhVmxsWmNmQ2pFcFl3d0VsU2FicnZLY3FqQjAwYnlQSGRQSHo0UXZ3?=
 =?utf-8?B?QzRqOUVMOEQ0bHAxeVJTWFQxWHUrZnJEZmtmdEp2eVlGZy9SK2YwZDRqTE1Y?=
 =?utf-8?B?cFBWajR1c1hwZ2NDMlBsNGJLckZUSkNsdGpDblpnVUlNOVByMUplV214YkJO?=
 =?utf-8?B?RlFGdGZ0K3VsWHZVM0dVenMrZkZXSDRTWGlwSGQzTExwOWRicC9RZ3c3QWd1?=
 =?utf-8?B?b1F1ZUJrZlBmczNoOXNwb2M1WEVGQUgyQk04d1hndXZzMXp6ZllRUXhzYk1z?=
 =?utf-8?B?dVIzaTJRaHJQMGxIZEVTQkllZktyS2w0aUdjMDAwOTEvNUNMMmQxNGdRY0tV?=
 =?utf-8?B?eThtdFRsMEFGc0ZSUHE2OThkR1c2b0JUY1hzUEtrV2xsMDczbnBOamtDb2VU?=
 =?utf-8?B?Y2tzYldjNkRITmFSZFRmQis3OHEvWHFHbW9UTFRkZFRoSFhmdCtzbTFYYWhW?=
 =?utf-8?B?Rjk4UGVvQjZBdUsycFBwVHpnSnlDNXdCZTZrU015NnhQK1ZIQjVRU0NqVWdu?=
 =?utf-8?B?NS9nb2FLM0NBbmJ6RWVXaEFhTTdNZnFzcG9YVERDOElBQkdpNFZlVEM2MkVx?=
 =?utf-8?B?bGp5ZHhIRmZCNTd3NU5VaFl4bWJPdEdqYXlpUVlYNlYyWG9NVXhEU2xQRWFq?=
 =?utf-8?B?TFV4SDg3QkVMMXBJVXlqWG81bG4xUlFVbXRrYzhpeEVGQjhocWxvU29VOUZl?=
 =?utf-8?B?TFFyWkdIbzZzaTBya21yN0xyTjNCS0d0b3VJanVubUxtTFJITEFpT0hZclZU?=
 =?utf-8?B?VUI5K0xNbGJzWkhFNEZNRnFDZXVMbDFxcVhmRDVpanA0VnRaS3FVdHp5NXdj?=
 =?utf-8?B?RmdOaGZRS0RWZm1QY3V6VVVYWlpwMExGNGk3VGF5ZEtUc1VDcHY5dTk3TXd0?=
 =?utf-8?B?N2VZMlJrdHd4SkpHZTBuaFp6M1JEZDhvVjdUdmlwaEtxVXgxY2FhSnd4clB5?=
 =?utf-8?Q?lMafO1bHjM6SwHzJGYC5vZTcK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53525f3e-10a3-4615-78df-08dc29b65d4a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 21:30:40.7344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pm4CI6R66Hp4JifBpSl1cJmqPuLW4obvmExr+uf3G3joybSLQYJxE1m5cJSs48frH++nvBdV0nv5TE9yME3FGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685



On 2/8/24 2:00 PM, Ben Cheatham wrote:
> Implement CXL helper functions in the EINJ module for getting/injecting
> available CXL protocol error types and export them to sysfs under
> kernel/debug/cxl.
> 
> The kernel/debug/cxl/einj_types file will print the available CXL
> protocol errors in the same format as the available_error_types
> file provided by the EINJ module. The
> kernel/debug/cxl/$dport_dev/einj_inject is functionally the same as the
> error_type and error_inject files provided by the EINJ module, i.e.:
> writing an error type into $dport_dev/einj_inject will inject said error
> type into the CXL dport represented by $dport_dev.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  Documentation/ABI/testing/debugfs-cxl |  22 ++++
>  MAINTAINERS                           |   1 +
>  drivers/acpi/apei/einj.c              | 158 ++++++++++++++++++++++++--
>  drivers/cxl/core/port.c               |  39 +++++++
>  include/linux/einj-cxl.h              |  45 ++++++++
>  5 files changed, 255 insertions(+), 10 deletions(-)
>  create mode 100644 include/linux/einj-cxl.h
> 
> diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
> index fe61d372e3fa..bcd985cca66a 100644
> --- a/Documentation/ABI/testing/debugfs-cxl
> +++ b/Documentation/ABI/testing/debugfs-cxl
> @@ -33,3 +33,25 @@ Description:
>  		device cannot clear poison from the address, -ENXIO is returned.
>  		The clear_poison attribute is only visible for devices
>  		supporting the capability.
> +
> +What:		/sys/kernel/debug/cxl/einj_types
> +Date:		January, 2024
> +KernelVersion:	v6.9
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Prints the CXL protocol error types made available by
> +		the platform in the format "0x<error number>	<error type>".
> +		The <error number> can be written to einj_inject to inject
> +		<error type> into a chosen dport.
> +
> +What:		/sys/kernel/debug/cxl/$dport_dev/einj_inject
> +Date:		January, 2024
> +KernelVersion:	v6.9
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(WO) Writing an integer to this file injects the corresponding
> +		CXL protocol error into $dport_dev ($dport_dev will be a device
> +		name from /sys/bus/pci/devices). The integer to type mapping for
> +		injection can be found by reading from einj_types. If the dport
> +		was enumerated in RCH mode, a CXL 1.1 error is injected, otherwise
> +		a CXL 2.0 error is injected.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9104430e148e..02d7feb2ed1f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5246,6 +5246,7 @@ L:	linux-cxl@vger.kernel.org
>  S:	Maintained
>  F:	drivers/cxl/
>  F:	include/uapi/linux/cxl_mem.h
> +F:  include/linux/einj-cxl.h
>  F:	tools/testing/cxl/
>  
>  COMPUTE EXPRESS LINK PMU (CPMU)
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 73dde21d3e89..9137cc01f791 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -21,6 +21,7 @@
>  #include <linux/nmi.h>
>  #include <linux/delay.h>
>  #include <linux/mm.h>
> +#include <linux/einj-cxl.h>
>  #include <linux/platform_device.h>
>  #include <asm/unaligned.h>
>  
> @@ -37,6 +38,20 @@
>  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
>  				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
>  				ACPI_EINJ_MEMORY_FATAL)
> +#ifndef ACPI_EINJ_CXL_CACHE_CORRECTABLE
> +#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     BIT(12)
> +#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   BIT(13)
> +#define ACPI_EINJ_CXL_CACHE_FATAL           BIT(14)
> +#define ACPI_EINJ_CXL_MEM_CORRECTABLE       BIT(15)
> +#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     BIT(16)
> +#define ACPI_EINJ_CXL_MEM_FATAL             BIT(17)
> +#endif
> +#define CXL_ERROR_MASK		(ACPI_EINJ_CXL_CACHE_CORRECTABLE | \
> +				ACPI_EINJ_CXL_CACHE_UNCORRECTABLE | \
> +				ACPI_EINJ_CXL_CACHE_FATAL | \
> +				ACPI_EINJ_CXL_MEM_CORRECTABLE | \
> +				ACPI_EINJ_CXL_MEM_UNCORRECTABLE | \
> +				ACPI_EINJ_CXL_MEM_FATAL)
>  
>  /*
>   * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
> @@ -543,8 +558,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  	if (type & ACPI5_VENDOR_BIT) {
>  		if (vendor_flags != SETWA_FLAGS_MEM)
>  			goto inject;
> -	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
> +	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
>  		goto inject;
> +	} else if ((type & CXL_ERROR_MASK) && (flags & SETWA_FLAGS_MEM)) {
> +		goto inject;
> +	}
>  
>  	/*
>  	 * Disallow crazy address masks that give BIOS leeway to pick
> @@ -596,6 +614,9 @@ static const char * const einj_error_type_string[] = {
>  	"0x00000200\tPlatform Correctable\n",
>  	"0x00000400\tPlatform Uncorrectable non-fatal\n",
>  	"0x00000800\tPlatform Uncorrectable fatal\n",
> +};
> +
> +static const char * const einj_cxl_error_type_string[] = {
>  	"0x00001000\tCXL.cache Protocol Correctable\n",
>  	"0x00002000\tCXL.cache Protocol Uncorrectable non-fatal\n",
>  	"0x00004000\tCXL.cache Protocol Uncorrectable fatal\n",
> @@ -621,29 +642,44 @@ static int available_error_type_show(struct seq_file *m, void *v)
>  
>  DEFINE_SHOW_ATTRIBUTE(available_error_type);
>  
> -static int error_type_get(void *data, u64 *val)
> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
>  {
> -	*val = error_type;
> +	int cxl_err, rc;
> +	u32 available_error_type = 0;
> +
> +	if (!einj_initialized)
> +		return -ENXIO;
> +
> +	rc = einj_get_available_error_type(&available_error_type);
> +	if (rc)
> +		return rc;
> +
> +	for (int pos = 0; pos < ARRAY_SIZE(einj_cxl_error_type_string); pos++) {
> +		cxl_err = ACPI_EINJ_CXL_CACHE_CORRECTABLE << pos;
> +
> +		if (available_error_type & cxl_err)
> +			seq_puts(m, einj_cxl_error_type_string[pos]);
> +	}
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_NS_GPL(einj_cxl_available_error_type_show, CXL);
>  
> -static int error_type_set(void *data, u64 val)
> +static int validate_error_type(u64 type)
>  {
> +	u32 tval, vendor, available_error_type = 0;
>  	int rc;
> -	u32 available_error_type = 0;
> -	u32 tval, vendor;
>  
>  	/* Only low 32 bits for error type are valid */
> -	if (val & GENMASK_ULL(63, 32))
> +	if (type & GENMASK_ULL(63, 32))
>  		return -EINVAL;
>  
>  	/*
>  	 * Vendor defined types have 0x80000000 bit set, and
>  	 * are not enumerated by ACPI_EINJ_GET_ERROR_TYPE
>  	 */
> -	vendor = val & ACPI5_VENDOR_BIT;
> -	tval = val & 0x7fffffff;
> +	vendor = type & ACPI5_VENDOR_BIT;
> +	tval = type & 0x7fffffff;
>  
>  	/* Only one error type can be specified */
>  	if (tval & (tval - 1))
> @@ -652,9 +688,105 @@ static int error_type_set(void *data, u64 val)
>  		rc = einj_get_available_error_type(&available_error_type);
>  		if (rc)
>  			return rc;
> -		if (!(val & available_error_type))
> +		if (!(type & available_error_type))
>  			return -EINVAL;
>  	}
> +
> +	return 0;
> +}
> +
> +static int cxl_dport_get_sbdf(struct pci_dev *dport_dev, u64 *sbdf)
> +{
> +	struct pci_bus *pbus;
> +	struct pci_host_bridge *bridge;
> +	u64 seg = 0, bus;
> +
> +	pbus = dport_dev->bus;
> +	bridge = pci_find_host_bridge(pbus);
> +
> +	if (!bridge)
> +		return -ENODEV;
> +
> +	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
> +		seg = bridge->domain_nr << 24;
> +
> +	bus = pbus->number << 16;
> +	*sbdf = seg | bus | dport_dev->devfn;
> +
> +	return 0;
> +}
> +
> +int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
> +{
> +	u64 param1 = 0, param2 = 0, param4 = 0;
> +	u32 flags;
> +	int rc;
> +
> +	if (!einj_initialized)
> +		return -ENXIO;
> +
> +	/* Only CXL error types can be specified */
> +	if (type & ~CXL_ERROR_MASK || (type & ACPI5_VENDOR_BIT))
> +		return -EINVAL;
> +
> +	rc = validate_error_type(type);
> +	if (rc)
> +		return rc;
> +
> +	param1 = (u64) rcrb;
> +	param2 = 0xfffffffffffff000;
> +	flags = 0x2;
> +
> +	return einj_error_inject(type, flags, param1, param2, 0, param4);
> +}
> +EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_rch_error, CXL);
> +
> +int einj_cxl_inject_error(struct pci_dev *dport, u64 type)
> +{
> +	u64 param1 = 0, param2 = 0, param4 = 0;
> +	u32 flags;
> +	int rc;
> +
> +	if (!einj_initialized)
> +		return -ENXIO;
> +
> +	/* Only CXL error types can be specified */
> +	if (type & ~CXL_ERROR_MASK || (type & ACPI5_VENDOR_BIT))
> +		return -EINVAL;
> +
> +	rc = validate_error_type(type);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_dport_get_sbdf(dport, &param4);
> +	if (rc)
> +		return rc;
> +
> +	flags = 0x4;
> +
> +	return einj_error_inject(type, flags, param1, param2, 0, param4);
> +}
> +EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_error, CXL);
> +
> +static int error_type_get(void *data, u64 *val)
> +{
> +	*val = error_type;
> +
> +	return 0;
> +}
> +
> +static int error_type_set(void *data, u64 val)
> +{
> +	int rc;
> +
> +	/* CXL error types have to be injected from cxl debugfs */
> +	if (val & CXL_ERROR_MASK && !(val & ACPI5_VENDOR_BIT))
> +		return -EINVAL;
> +
> +	rc = validate_error_type(val);
> +	if (rc)
> +		return rc;
> +
>  	error_type = val;
>  
>  	return 0;
> @@ -690,6 +822,12 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
>  	return 0;
>  }
>  
> +bool einj_is_initialized(void)
> +{
> +	return einj_initialized;
> +}
> +EXPORT_SYMBOL_GPL(einj_is_initialized);
> +
>  static int __init einj_probe(struct platform_device *pdev)
>  {
>  	int rc;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 8c00fd6be730..c52c92222be5 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -3,6 +3,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/memregion.h>
>  #include <linux/workqueue.h>
> +#include <linux/einj-cxl.h>
>  #include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
> @@ -797,6 +798,37 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>  	return rc;
>  }
>  
> +DEFINE_SHOW_ATTRIBUTE(einj_cxl_available_error_type);
> +
> +static int cxl_einj_inject(void *data, u64 type)
> +{
> +	struct cxl_dport *dport = data;
> +
> +	if (dport->rch)
> +		return einj_cxl_inject_rch_error(dport->rcrb.base, type);
> +
> +	return einj_cxl_inject_error(to_pci_dev(dport->dport_dev), type);
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject, "%llx\n");
> +
> +static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
> +{
> +	struct dentry *dir;
> +
> +	/*
> +	 * dport_dev needs to be a PCIe port for CXL 2.0+ ports because
> +	 * EINJ expects a dport SBDF to be specified for 2.0 error injection.
> +	 */
> +	if (!einj_is_initialized() ||
> +	    (!dport->rch && !dev_is_pci(dport->dport_dev)))
> +		return;
> +
> +	dir = cxl_debugfs_create_dir(dev_name(dport->dport_dev));
> +
> +	debugfs_create_file("einj_inject", 0200, dir, dport,
> +			    &cxl_einj_inject_fops);
> +}
> +
>  static struct cxl_port *__devm_cxl_add_port(struct device *host,
>  					    struct device *uport_dev,
>  					    resource_size_t component_reg_phys,
> @@ -1144,6 +1176,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  	if (dev_is_pci(dport_dev))
>  		dport->link_latency = cxl_pci_get_latency(to_pci_dev(dport_dev));
>  
> +	cxl_debugfs_create_dport_dir(dport);
> +
>  	return dport;
>  }
>  
> @@ -2220,6 +2254,11 @@ static __init int cxl_core_init(void)
>  
>  	cxl_debugfs = debugfs_create_dir("cxl", NULL);
>  
> +	if (einj_is_initialized()) {
> +		debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
> +				    &einj_cxl_available_error_type_fops);
> +	}
> +
>  	cxl_mbox_init();
>  
>  	rc = cxl_memdev_init();
> diff --git a/include/linux/einj-cxl.h b/include/linux/einj-cxl.h
> new file mode 100644
> index 000000000000..af57cc8580a6
> --- /dev/null
> +++ b/include/linux/einj-cxl.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * CXL protocol Error INJection support.
> + *
> + * Copyright (c) 2023 Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Author: Ben Cheatham <benjamin.cheatham@amd.com>
> + */
> +#ifndef CXL_EINJ_H
> +#define CXL_EINJ_H
> +
> +#include <linux/pci.h>
> +
> +#if IS_ENABLED(CONFIG_ACPI_APEI_EINJ)

I was testing some other work using this kernel and was getting a linker error
when I had CXL_BUS set to 'y' and ACPI_APEI_EINJ set to 'm'. I went ahead and
solved it by changing the line above to use IS_REACHABLE() instead. The change
shouldn't actually affect the functionality of the patch since this is in a build
configuration where the CXL driver isn't using the EINJ module since CONFIG_CXL_EINJ
is set to n due to Kconfig restraints.

I can submit another version of this series with this fix, but I don't think it
makes much sense for a 1 line change, so I've but a diff below with the change
for whoever ends up putting this in their tree:

diff --git a/include/linux/einj-cxl.h b/include/linux/einj-cxl.h
index af57cc8580a6..70d411ea4629 100644
--- a/include/linux/einj-cxl.h
+++ b/include/linux/einj-cxl.h
@@ -12,7 +12,7 @@
 
 #include <linux/pci.h>
 
-#if IS_ENABLED(CONFIG_ACPI_APEI_EINJ)
+#if IS_REACHABLE(CONFIG_ACPI_APEI_EINJ)
 int einj_cxl_available_error_type_show(struct seq_file *m, void *v);
 int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type);
 int einj_cxl_inject_rch_error(u64 rcrb, u64 type);

Thanks,
Ben

> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v);
> +int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type);
> +int einj_cxl_inject_rch_error(u64 rcrb, u64 type);
> +bool einj_is_initialized(void);
> +#else
> +static inline int einj_cxl_available_error_type_show(struct seq_file *m,
> +						     void *v)
> +{
> +	return -ENXIO;
> +}
> +
> +static inline int einj_cxl_type_show(struct seq_file *m, void *data)
> +{
> +	return -ENXIO;
> +}
> +
> +static inline int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type)
> +{
> +	return -ENXIO;
> +}
> +
> +static inline int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
> +{
> +	return -ENXIO;
> +}
> +
> +static inline bool einj_is_initialized(void) { return false; }
> +#endif
> +
> +#endif

