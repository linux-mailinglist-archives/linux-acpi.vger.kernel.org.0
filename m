Return-Path: <linux-acpi+bounces-12997-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2217A87870
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 09:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF5718923DE
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 07:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF751B0434;
	Mon, 14 Apr 2025 07:09:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8361ACEAF;
	Mon, 14 Apr 2025 07:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744614541; cv=none; b=pWY2mf8/L2mOlL8lGOZhrD5pDmmHBVjdfcswdyZGi1AEQ1U1a5zBW1F+zMyPn+RXpItQHYhqugpsJx5IUa7zO5LTAUoALRYY7Hs/rqGAFukrjpDxPO8zrpTRzIW9pmYSgtTErFl02iYPyLZHrq9WuoAvALLkgNH+B9cNVHTDtRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744614541; c=relaxed/simple;
	bh=bAQMdnKenSyxzJV0sedkupt48oA6gVJVUPppVV+uz4M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GtEUQuNpuchq1OXrbjbk+2/fR6DwV1FY43WuRYem9H8PgaSEZPdsQkmoCyn3InlnPVMxFEdUtxmGLCvQLdVfDwiWItu1zFWAtH0oPZ2jA9YpsrxddnPLtX08p8Vdt94Yg/sZ/asSb1nBskbzwRglSVgstzFHxLQylnQtDxjVvKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E5R3K4025348;
	Mon, 14 Apr 2025 07:08:41 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45yf58hp0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 14 Apr 2025 07:08:40 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Mon, 14 Apr 2025 00:08:39 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Mon, 14 Apr 2025 00:08:35 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <andriy.shevchenko@linux.intel.com>
CC: <dakr@kernel.org>, <djrscally@gmail.com>, <dvyukov@google.com>,
        <gregkh@linuxfoundation.org>, <heikki.krogerus@linux.intel.com>,
        <jgg@nvidia.com>, <kevin.tian@intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <nicolinc@nvidia.com>, <rafael@kernel.org>,
        <sakari.ailus@linux.intel.com>,
        <syzbot+2ff22910687ee0dfd48e@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>, <yi.l.liu@intel.com>
Subject: Re: [PATCH] software node: Prevent link creation failure from causing kobj reference count imbalance
Date: Mon, 14 Apr 2025 15:08:34 +0800
Message-ID: <20250414070834.1224154-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <Z_ypLhYQwGf41hVK@smile.fi.intel.com>
References: <Z_ypLhYQwGf41hVK@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=UPPdHDfy c=1 sm=1 tr=0 ts=67fcb478 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=co-kc5KNQRhJfrCQoXsA:9 a=D0TqAXdIGyEA:10
 a=xa8LZTUigIcA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-GUID: DNUT0E3mijy0uFmoGDGlcL6iD6Co6v7W
X-Proofpoint-ORIG-GUID: DNUT0E3mijy0uFmoGDGlcL6iD6Co6v7W
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=345 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1011 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504140050

On Mon, 14 Apr 2025 09:20:30 +0300, Andy Shevchenko wrote:
> On Fri, Apr 11, 2025 at 08:42:02AM +0800, Lizhi Xu wrote:
> > syzbot reported a uaf in software_node_notify_remove. [1]
> >
> > When any of the two sysfs_create_link() in software_node_notify() fails,
> > the swnode->kobj reference count will not increase normally, which will
> > cause swnode to be released incorrectly due to the imbalance of kobj reference
> > count when executing software_node_notify_remove().
> >
> > Increase the reference count of kobj before creating the link to avoid uaf.
> >
> > [1]
> 
> Please, reduce this to ~5-7 lines only. This is how Submitting Patches document
> recommends to put backtraces in the commit messages:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages
Ok, I will reduce the calltrace, and send V2 patch.
> 
> > Fixes: 9eb59204d519 ("iommufd/selftest: Add set_dev_pasid in mock iommu")
> > Reported-by: syzbot+2ff22910687ee0dfd48e@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=2ff22910687ee0dfd48e
> 
> > Tested-by: syzbot+2ff22910687ee0dfd48e@syzkaller.appspotmail.com
> 
> Where is the positive result of it? I can't find the respective log.
> To me this one
> https://syzkaller.appspot.com/x/report.txt?x=158af070580000
> doesn't sound as a useful report as I don't know if this patch fixes one
> regression and introduced another.
You can see: https://syzkaller.appspot.com/x/log.txt?x=118af07058000
For tasks related to the reproducing program, there are only FAULT_INJECTION
related problems in the log, no other problems, and the log record duration
exceeds 240 seconds, and no uaf occurs, which is enough to prove that the
problem has been fixed.

BR,
Lizhi

