Return-Path: <linux-acpi+bounces-14310-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5EDAD7EC2
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 01:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4D63A1E8C
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 23:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4582367A2;
	Thu, 12 Jun 2025 23:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="B0sIfut5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023120.outbound.protection.outlook.com [52.101.44.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105F51FF61E;
	Thu, 12 Jun 2025 23:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749770024; cv=fail; b=aD5cEGRVbA5biWlRKFoEG2djaGFCxkFzecUGVoff1oB7N89PIhuLJFdAzRfH7HJuVnjkyp/SbfbZORKpfD/QPiT9PX7T0pxGVs1YpY4haE92e4zaLiTnYbb0bTQMEWsseQpWwdi9tmvTZuXfr8xnvhBnlvDYY8upOdFj7pF0cjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749770024; c=relaxed/simple;
	bh=Y00kDUaV+JcRGqQrpY4w28/0woKuZTvUODKannSoKCw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MxHFitVz5JKL6wvrv88qaCcxsF1cSGpR9OZTlw6HV2aRL0AjPgz8cgYaLZX2XUwGMCNcMRnZIK1ecYfDSNhU/jyvFLkuZz/0GYI+tbv8fRZDeysE+J2l4hM2p0ibR7nPqx9DvMbQThF6oV0eBld1mqPMsr8XfYmhfJ5v5hhCd3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=B0sIfut5; arc=fail smtp.client-ip=52.101.44.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTl9wtlf+CROaXXo1w3CNhLQeoOif5D/881M0PYHlfWxrqkXXFCjPJ49qYylWRlGBXmKasOK4TJAXD+Of+tVff3YFCIyiIkJJTnbylHwZwLlRANHDtKsrO+TCIcULjzH8rW0VXd19D8BDDjO+KD7HXJnnhTWtf8/bxOI7Q3J1r2AvemqDpmLIdc0F2aEQpQFFedAFBaacgtcJtMTbFIX/qD4qI1uklGeUkjmSwenVJIITw7QRrX7yh2VEVXRWsElTKLCPkxPPEmZZ9IRV5c8SWGBoJx8G/gw597I/TP7b7NVYtgxzkNhx6Eg9dpZ0AhkAUmKg/Nf0+QrPE5TAyQVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcm3m9yaKvaeZGkdaLoyOkUUYCBzJ0uw2TFfwUzURNE=;
 b=YY3e67faA/k9Ocn7W0oALtewGhR95rMsBR2wSkA+QB4SERRU8kOVbeHeRYPmS8XVT5k31dI0C0zmjCtrlCDqKQGApF+p3dQhv6we1eCoMKRmpPorBv9SHZ7+SxdMo9ZPHC6CFmaz/acg+hELo4ay2/i3WqiBnEpBQ8VTHJr2SQC6KPg7s2WSVk6zPpz337jhpDkKphpmbF7zaqP9YYWtCAjIxcmxhUtQsqHZ+K9e+4aGKIVUmy1nIxtzad3y9cj2XuoQoLGbqYiYqhm8gMY8SQ7jObVfTrYP4nu4xNOTpyNjqE0e7wKpKPYlbFWHAEJi3mRuzo9+rKFiNS3onUP8WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcm3m9yaKvaeZGkdaLoyOkUUYCBzJ0uw2TFfwUzURNE=;
 b=B0sIfut5Irr9l46AXvhjkhNCd+XczSgZOTKdDnY4GibtKyT5MgSc2ORThVqjYxXH0CGlexBUVt3M01u0848ZdZZgnQA9FlSfcJuhWPgcb8DvS8v/cEwXQY4Xf7PZaNGRwo9/g/32G4NfcHilXhy5lAjVYnEGFVLXgBFrhfH6zBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS7PR01MB9364.prod.exchangelabs.com (2603:10b6:8:24f::14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.19; Thu, 12 Jun 2025 23:13:39 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%7]) with mapi id 15.20.8835.019; Thu, 12 Jun 2025
 23:13:39 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	kees@kernel.org,
	gustavoars@kernel.org,
	zaidal@os.amperecomputing.com,
	Jonathan.Cameron@huawei.com,
	sudeep.holla@arm.com,
	jonathanh@nvidia.com,
	u.kleine-koenig@baylibre.com,
	dan.carpenter@linaro.org,
	viro@zeniv.linux.org.uk,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	dan.j.williams@intel.com,
	gregkh@linuxfoundation.org,
	peterz@infradead.org,
	dave.jiang@intel.com,
	Benjamin.Cheatham@amd.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v9 0/7 RESEND] Enable EINJv2 Support
Date: Thu, 12 Jun 2025 16:13:20 -0700
Message-ID: <20250612231327.84360-1-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::35) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DS7PR01MB9364:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bee0a1a-8c0a-452c-1c4d-08ddaa06c405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zx9Y1GB+6H5qb733R8sDjvx62ntQ+lRPFFID4/aNUYT8XWVtk22u3wxumWrV?=
 =?us-ascii?Q?SHoEp0Pr0QddXskz3TnjBryONkonFonILaDUw3Cp9ZGdwN0EsyXygyUnweM6?=
 =?us-ascii?Q?dc6U8/Da6I4j5l2vTem3ashrDOFSwkPJyeKCRmI+UsWA6y9wiNhKJxgxdRIL?=
 =?us-ascii?Q?4/8foxaVwCKEBOQugiY8CqKZLW9RO7oEhEybO/o8Cx1R8eMnxxl6dI6J0zwG?=
 =?us-ascii?Q?d3S49Z8hdJ6YAdgzo6lGV2bOU5K8UH/zinI9+s/dwH5mMg6rHWfyO24yeTr7?=
 =?us-ascii?Q?WnC6/O/hy9Ik/dPpFJfFgVjpRNp2Pzx6JFZ6aMVaitAkYxgavg3iiGGn4DYK?=
 =?us-ascii?Q?NWM1AsL8fiDysWdBWOyeN7khjN6Do5chb+Ma5LfeBVt73tHypItXyrxBst+8?=
 =?us-ascii?Q?Icy2NQW9sS1HEstSdI4osbD3JMutQ+qkgBse+236vPX1Lo9YfwYOuHgtvPFX?=
 =?us-ascii?Q?dP5+8DheCU0kAr4kE1OsiqbA/4O8mANRAL78d/LtullWAjCg5HgRkYk86C2s?=
 =?us-ascii?Q?ZusFs+hOQWUMS6hlZGQc1nmSbIIchPQ+LCkXEsyi0LvdJ+5epiQTa2gAP4yF?=
 =?us-ascii?Q?LK8iqjZPoHdZyQtLLX5WInfPZ02mjiNhcq9KEAd+FKZ7FNUBdC1DRrydgC2b?=
 =?us-ascii?Q?Y6BeJY6unY8jsfolLfnivpQGYbcM97O4emHcTZNl7yAQcGO9vke+ZNuYkOGy?=
 =?us-ascii?Q?DRhAhgR+3v6PL/pJD4mOHiKAh8Lv7jVf+oYLHVitXEXwxCZDIthR3V17LdGG?=
 =?us-ascii?Q?hMNMQqFb8jU9DA+4vby1XQ3UHTMvgj71dNj+eNhgbct0V+po/KMe+uepYqVB?=
 =?us-ascii?Q?gSNYulw8xUIhIVHyWKgjc26XQ32Ph6wcromMZskKOqkHYyE7xJbvVifFWRSP?=
 =?us-ascii?Q?JCW8XVigM0p00XC+REPdYYvm73aoRycXjEUWeupxEzataZirbxibFVQr05A4?=
 =?us-ascii?Q?N/WunCBZgT2bJMxS+IQ6FPteDVrQAjSCjwrC6hp9ppG3H7U+YBcla1AjfY4c?=
 =?us-ascii?Q?RURZ5k4m6Vr5UrAKn52YYbcZ8rtMoCLKVCp7beq+UrSNNVujFGxEmoSi/MPi?=
 =?us-ascii?Q?TKj50/iucc9ww0WVgGSUggS8lM4enO1JDyvK6u7Z4oACr6zfaBttjOci4nH+?=
 =?us-ascii?Q?zMdasoA52CQS4R9viQX7Hq+31DcMzNyQZ9/+L/vRJyQ2fv+f5IWcUkhSI10z?=
 =?us-ascii?Q?9R4ABjnMhwP7RuZJxa0SyxJn0/dYWM6tPsx69b/Xu17MsEac81lrWEHSeEkv?=
 =?us-ascii?Q?03W9+x5VbIfJoTGOZyJpRV8uJBhpNe5pFNAsvRVe//UgNuDPd8n/mdhmlXmk?=
 =?us-ascii?Q?HPJ9w0KBZgCynZf25d7agqXwl6J4932Zt+oRm4Ysc/ynSB0kexzWHb7rZKKC?=
 =?us-ascii?Q?71N2gCXOy2tREfZtY0kFz4N3PaEAetZbCv+WmphvfuIwUYHRbGa1pbMQtYUr?=
 =?us-ascii?Q?dheg5qa06XPbt+XthzkvGiuAy8ZLproF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zs9tdsDlLL1sKqWUClFqDPa8jssoGBlLpiYhGGrnZgkUhIvRbBhgB71F+vKW?=
 =?us-ascii?Q?OL9Y1oojf682nwMWiIUYv5JqTaYD84lEOulLzhMI+Mh4nIpFxsq+wDSCrwYH?=
 =?us-ascii?Q?Z/O9DSQEu2SNcS5FiRVh9U0lQBUIaZaB9fOd8V2/KdjUseQ89bycPDr5Dk44?=
 =?us-ascii?Q?6KD9uoXZZSekiTUfYERd3gPIZ2euP57m8+PTFAfllA8EagL2Cro07P4A4ysm?=
 =?us-ascii?Q?TxbBd+tTCYYUSSwdFMpuid1nKxNm2PdyZb3z9TZf0CfBNeDs++7/NtwXcSQn?=
 =?us-ascii?Q?Oe286UKUMBYbktZBccht7MMFRnXRz6TqutLpd0NQCKtM6ntJb2QqTMb2BRuN?=
 =?us-ascii?Q?GpjAYJ37gwAus41nq9x2jjVhJGT5XqgaYPM/NSRhiVhIj8Njo4jyOFElnoJ9?=
 =?us-ascii?Q?VSCMihRKUpcVYDxm3Wy4ppIZV6CPR03hj7+hIVJCETMsy4uRgcuKqyXgHxHk?=
 =?us-ascii?Q?SOod5HGp9GKXsbcrAW2+VkqKzlxjGiUXnRgXiMUdzlSFGyGmnG6E/peTlmyj?=
 =?us-ascii?Q?9cpF4s00DYG0NYyEv9WZiUQcNeTHzQBduKOfXJMMjKV5t/rgUhSAX7YVnXg9?=
 =?us-ascii?Q?NaP9v+kN/0efGgrx7Ha5LZrt+UFK35dqAiCeOMjo41ftFzh27hXEsdOnsfFZ?=
 =?us-ascii?Q?jA2yzmixvo1sYsXd+y/AyaTZA+ooRaYjg5C+EaysMybSt7bdo7T7XvrFvzuw?=
 =?us-ascii?Q?0NuLtf2f5/RgIH2AKnH6k7e8LgDEwxVn3n5KsXleoH/jJq33zFu4QeBeaKMY?=
 =?us-ascii?Q?uRFVfcwR7M39YLDVeVqBPTGdTKvZiJNE7EC7bqo1uydno7eZMiHfSKoJ/7Fk?=
 =?us-ascii?Q?5F4PNFe0eKFWv5Hhqqz9x7XPxQCdIhV39JIN+VzTAyLhmLT2sgMKW+381qJt?=
 =?us-ascii?Q?w/SI8wSFRAmNdhpSiqXQ+vqtRr+dU3nO5jCAyhmnB5pnxYNtRrY16mnQTA0W?=
 =?us-ascii?Q?BcKQbS8eOu83wmgVxLYl+vjzqXKvP84FGAmDBor9UF+xrgtapsogOzp3Bwl9?=
 =?us-ascii?Q?6A0FypThZtl3Hx0/Nnk6rbDAtmgmqxmEDIRGCnPMYBLEJ5pO69h4uKOG4esR?=
 =?us-ascii?Q?6rv9c7+Jt3mFHIItP9p+LTwxYqAUvKUxH55Iv2RCiphvkDrqH1LsnGytweQ3?=
 =?us-ascii?Q?a24QQAf2gQdwaX2a9quhhkj52FEU3Jjb8NgWRRSZ3qxOAGXvK5z4XWo/V1sw?=
 =?us-ascii?Q?aZ+7i7EBif1ldqvy/5V2fa49/2tgwHUdLIHh2obYDVPPDi6oAOWCp1PxrT3g?=
 =?us-ascii?Q?Yv+uNIrXluGgV09GFcVYB23FoEqrGl0gflU6C4edSIOxlyBewX+iF2bueSca?=
 =?us-ascii?Q?Mry1cegfssU+LeHVjipduZtKPhRceuS9v97qNkd6yUW1OEYFY7K0QVsUGr/q?=
 =?us-ascii?Q?KIrGB5zsiHDxDXmFD9W3JD/aHHfo30eABULVCknosTcwbgmDCrW2Ms83gfTz?=
 =?us-ascii?Q?0frhOLaJAKgTC4mEKy29wub/vuhpRA9MFm9oqZpyDEM6VTIJ0O2UsSz10vMC?=
 =?us-ascii?Q?a0uGWxdN+/sIaKGbfZoI49geHFHhsX8hXkrjd38++7v0Y7t4qOWoSTp2f2D9?=
 =?us-ascii?Q?nuCWeA3fPkmzM2/Ua8Umhomq1wwclBCwy4Yks95aMcaFGmwnVn+VMQJoTgPk?=
 =?us-ascii?Q?tx5oxSik5J7vbDcRQ1FqxIk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bee0a1a-8c0a-452c-1c4d-08ddaa06c405
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 23:13:39.4574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NuNqO6udT7+oGPIJydMxxuon/3YabAGVGYeyrD61SMLj81vmykwsa5f1HDhL/IoPYkOklOC8KeUySv+Hwxb30a+A+EFhGCZMUi6KyAE2eLha6Jz5RMhlQ1BSdc55QGvM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB9364


The goal of this update is to allow the driver to simultaneously
support EINJ and EINJv2. The implementation follows ACPI 6.6
specs[1] that enables the driver to discover system capabilities
through GET_ERROR_TYPE.

Link: https://uefi.org/specs/ACPI/6.6/18_Platform_Error_Interfaces.html#error-injection [1]

V5:
        *Users no longer input component array size, instead it
         is counted by parsing the component array itself.
V6:
        *Fix memory leak.
        *If EINJv2 initialization failed, EINJv1 will still work, and
         probe function will continue with disabled EINJv2.
V7:
        *Update component array to take 128-bit values to match ACPI specs.
        *Enable Vendor EINJv2 injections
        *Moved component array parsing and validating to a separate
         function to improve readability.
V8:
        *Update UI to use single value files for component array.
        *Update links to point to recent ACPI 6.6 spec release.
        *Updated commit messages and documentation patch.
        *Dropped the first two patches as they were merged via
         ACPICA project.
V9:
	*Fix commit messages signed-off/reviewed-by order.
	*Fix sparse warning by defining syndrom_data as a
	 static struct.


Tony Luck (1):
  ACPI: APEI: EINJ: Create debugfs files to enter device id and syndrome

Zaid Alali (6):
  ACPI: APEI: EINJ: Fix kernel test sparse warnings
  ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities
  ACPI: APEI: EINJ: Add einjv2 extension struct
  ACPI: APEI: EINJ: Discover EINJv2 parameters
  ACPI: APEI: EINJ: Enable EINJv2 error injections
  ACPI: APEI: EINJ: Update the documentation for EINJv2 support

 .../firmware-guide/acpi/apei/einj.rst         |  33 ++
 drivers/acpi/apei/apei-internal.h             |   2 +-
 drivers/acpi/apei/einj-core.c                 | 372 ++++++++++++++----
 drivers/acpi/apei/einj-cxl.c                  |   2 +-
 4 files changed, 340 insertions(+), 69 deletions(-)

-- 
2.43.0


