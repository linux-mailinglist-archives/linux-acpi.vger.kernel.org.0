Return-Path: <linux-acpi+bounces-20486-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OdwDLi/cGmKZgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20486-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 12:59:52 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A013456679
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 12:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DC8598151E
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 11:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3443D3D0C;
	Wed, 21 Jan 2026 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HZWsLiQg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A40D2BF00B;
	Wed, 21 Jan 2026 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768995352; cv=none; b=AE5tk1HaBSxU6N1v+Uxzz5C8k8R6ZPErLt+g36YC63lg9VIEjB2bGBPaSu5HQkXyklxaYcrvht2RgKbgVvnf7+8cqRwdDOQEGpRs0bEzHsrVfkpf83UsA1U2GGnCo/xG4b759qe+JESz6biCGoLGK092i+W7HOKYrG1036Pr9qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768995352; c=relaxed/simple;
	bh=bHBMPY9HO3NNgD94UBQ6VrNTad3XNzZ6frePlgRVdoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G5SWmQh3MkSrNmlBJsXmhmWMkKhwkrycDGO+1n0aiZYss5Tp0CG5ixKAkRfBpa9XEIYz/NAs4HH6N36mhEnI8ubZtJY2zy9GVGs7V53ELBXZJJyoM2er1zAxRVoPsCiRdrWkV36hhiT/+Sduh85l0iHYuKakBbsMri+Z93BIQBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HZWsLiQg; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L5lVSj3867763;
	Wed, 21 Jan 2026 11:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=8xwYGu06AU1Qt1+9
	pk3v/UNkW3boHEjjOYdiHPzUxw8=; b=HZWsLiQgzxXi282AAHubvqsMCL8eGksO
	kBzg/ScvWpaMD33O+IjQYIMfYMePARWSzh3pEykj6UXbO+ZEieaAE3zuPUa9IvE3
	RJByd1iaq1KJq9avazWkpC3aBq5z3iIgnrmJ5PUS2l4ZuUuC7/yDy6BQ8iXEHBu8
	/ncVB3vzPGBioguToCZxCtCrAwHics5Mg6x4qGIkeVLWxPaDWQn9VoPOTTVLyJJ3
	Zx+M4DQHRenLlN+G/VpDD3/JpVfmFWErgCV0ROoqVN/I/KIwFCofCV1h2FxMz1e7
	LaFlJEE3e1mcwTAKfzMwHnV4496cTmhvW8unYrmYjtdDmjjfPoFAyQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4btagd27pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Jan 2026 11:35:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60LBCIrn019000;
	Wed, 21 Jan 2026 11:35:46 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4bsyrry2rv-1;
	Wed, 21 Jan 2026 11:35:46 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Johannes Thumshirn <morbidrsa@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v2 0/2] PCI: Init RCB from pci_configure_device and fix program_hpx_type2
Date: Wed, 21 Jan 2026 12:35:39 +0100
Message-ID: <20260121113544.4163457-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=727 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601210097
X-Authority-Analysis: v=2.4 cv=PqqergM3 c=1 sm=1 tr=0 ts=6970ba12 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=lkFEIk0dndTVLs1Xz8EA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12104
X-Proofpoint-ORIG-GUID: --DKfuDmNZSHM_aw1c2SFXZ7MXmO9D9g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA5NyBTYWx0ZWRfX4QwVyPLV1QSo
 EHSobTm9NlNjy1Wlt8wyj1jj+WHynLg0kQCjgef/92EKy/0Z4V/RYFNRQDMZ2qghB8I+cKIu77I
 eLkQS7EH0IPzuWStvhlJCdNRZ3aFn5RTWJtf3FZikQDx1lx34RoEDd/XNcQ1FsZfFPA8gqM2Au3
 eJVppTTzMClEOUEjLBAut5Iy+oCBDm0tNLDv6TxeaZD7/8xkLriBJZ6OKnKFyZyvNUtzV1iGvQT
 OKiscfYzvdifU0D0pDQ2ZuHRFDhqtYRhM4IbOeN4NvUpbXC+tRVQt/XRzzs9fQeW8/PPFfdKhWX
 qCp0spOLg5geiSI/yRHHedV1Rk35hlz8iS0BsV4bEsYSGuXLlIvRMKWyXdRSG++ufAG4TOKHJpO
 8YVRvqBkEE0pdxtqg7Rbbes76ybYh7fNlX9jFJM5ubGiko7PIQnh2rIKzxLQrtMOyJNI9Bc5K7J
 VuqKQV6QUPEdu8BZ5TsAADodKRSSbKKYyxTafMWY=
X-Proofpoint-GUID: --DKfuDmNZSHM_aw1c2SFXZ7MXmO9D9g
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20486-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[oracle.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[haakon.bugge@oracle.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A013456679
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series add the initialization of the Link Control register's RCB
to pci_configure_rcb() called from pci_configure_device() and also
cleans up the incorrect program_hpx_type2():

1. It should only be called when we own the PCIe native hotplug and
   not the AER ownership
2. It should only manipulate the AER-bits

In addition, the second commit adds a warning if the _HPX type2
record attempts to modify the Link Control register.

Håkon Bugge (2):
  PCI: Initialize RCB from pci_configure_device
  PCI/ACPI: Confine program_hpx_type2 to the AER bits

 drivers/pci/pci-acpi.c | 61 +++++++++++++++++++-----------------------
 drivers/pci/pci.h      |  3 +++
 drivers/pci/pcie/aer.c |  3 ---
 drivers/pci/probe.c    | 27 +++++++++++++++++++
 4 files changed, 57 insertions(+), 37 deletions(-)

--
2.43.5


