Return-Path: <linux-acpi+bounces-20773-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PGXIY+fe2nOGAIAu9opvQ
	(envelope-from <linux-acpi+bounces-20773-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 18:57:35 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CADB34CF
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 18:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7278D3027970
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 17:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF573559E3;
	Thu, 29 Jan 2026 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hE2jqJSj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651D1347BA5;
	Thu, 29 Jan 2026 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769709168; cv=none; b=gNdNTEjb+K03xq+1eF1hu+Lp8pdjRN1jotNM1+echxApUoE1H5tkLyh0R08KrOBEEHbmH4igR7X6+kZdzj4AdOZ7rWdIC1FFWIDY8PhdpFGEZrWbNcsghbxZ1ZpKeKjF1eutT9xDzftshSSsiY0hhCrZeTWnzQr+tqCc0KAedas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769709168; c=relaxed/simple;
	bh=QxiiPPt+ekeGse8NEqhH9wWWFK6OcjQT53evL1xJOyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iWNJWzXNJQeJdEmMRXnymDbeLkuyyc+UjXVDJSIuhxGNj5VlJGDkcHlOCE1AYiwz5Kyu66bd7HZ0qpKCynIdsFxtXi6IqIATcb+eRjbuIf8oZAOcUHv10eWgU1m6P7gj/W5CIS3b3d9vrv75EECZ9THYmwAwO3UNBJB20apcjpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hE2jqJSj; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TDgNDd542649;
	Thu, 29 Jan 2026 17:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=pmBuBV28xPNithxE
	qrLBazmgUjVpUVoV1jf59z1EQhQ=; b=hE2jqJSj2jOIoyQpOisFyWDjVwks7u+T
	cGJY3t1ChtVyYyDseG/sVaU9BgPtGicyFPlfRz11eSmseULJg1sB4zdo/IMbsT/8
	7ytAbxqKYpkWY+BEvxPiZ7B+s7IKhKEcVXK5i9NkKQQM+EtdEqh+zvOawdgDf3Ev
	VMIdXLUBMgjl6s/k0ed1ErWGXLq4+G8/i95KPGZGfb+O2eEKSr3lgrUKMhh8Uq90
	TYjlHzfl/0A+uXmloE3W1I7b+UexTVyWWhfZ1VAo4OXMY1TZvoLlUfWPOnVJpTpi
	bKiII3lFm6CKSARMd9OZirmheb8OCDBW+EDdU5OGrrmcONLySqfByQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by5dj3enq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 17:52:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60TGpg56019847;
	Thu, 29 Jan 2026 17:52:39 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4bvmhhyfc3-1;
	Thu, 29 Jan 2026 17:52:39 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Alex Williamson <alex@shazbot.org>,
        Johannes Thumshirn <morbidrsa@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v4 0/2] PCI: Init RCB from pci_configure_device and fix program_hpx_type2
Date: Thu, 29 Jan 2026 18:52:31 +0100
Message-ID: <20260129175237.727059-1-haakon.bugge@oracle.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=783 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601290126
X-Proofpoint-ORIG-GUID: kripMJWxb6KQn0jIrdOo-NMG8CM1D7OJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEyNiBTYWx0ZWRfXzzrHaI9stU78
 jm0wGZSavpb6OqBNgwMpGk2DEhFBT2sI6ZDEYoOvWVkAQyPcDK07XE5XoOZ3QJjTUSpRaJNXxfH
 yUplVQ/B3Td5OAwUVF/eGuJPQmn68clnhgSj8eMyl7e6F54xFoTxoeAnqR8wIB+lwPd0mkeM0yV
 luRe4tYoiPTmVtLtnNEgrWX/5lZAiQ6UZQXgmli5v85YyIIODyRb8Zye4Ya5VXmfmpxMg5yJ9eV
 FCGb50zaG2nVoOLz7X5q4PQEyaTf10cmJCfdYFXQCQxjcFg9z6c9PkaAoat3xlNEGcYZB0ab929
 9fmQMFUQpn7QLafLp2CuXlQYsUj9yZF7Q4ny9J5qeL66kzSsDf/plgZ+TCrFpXuRvO0YXGLNTYT
 TGuuekuKCGvZgAFWseUAEbN0DZM5BdJEzr/w0er+ow8XE1EkPh2lWkYsmcjVL92Rge6rKQYS4m9
 dkL7craxBOLn66y9PKvy/oJJk47YUT0VbhxoSyjE=
X-Authority-Analysis: v=2.4 cv=IrsTsb/g c=1 sm=1 tr=0 ts=697b9e68 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=3OD1d0GEu3Xej3sCmiwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12103
X-Proofpoint-GUID: kripMJWxb6KQn0jIrdOo-NMG8CM1D7OJ
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim];
	FREEMAIL_CC(0.00)[shazbot.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20773-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haakon.bugge@oracle.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E1CADB34CF
X-Rspamd-Action: no action

This series add the initialization of the Link Control register's RCB
to pci_configure_rcb() called from pci_configure_device() and also
cleans up the incorrect program_hpx_type2():

1. It should only be called when we own the PCIe native hotplug and
   not the AER ownership
2. It should only manipulate the AER-bits

In addition, the second commit adds a warning if the _HPX type2
record attempts to modify the Link Control register.

The programming of the device's RCB is constrained to the device types
where it is applicable and also skips VFs. If the Root Port's RCB
cannot be determined, we also skip the programming of the device's
RCB.

Then, we program the device's RCB according to the Root Port's setting.

Håkon Bugge (2):
  PCI: Initialize RCB from pci_configure_device()
  PCI/ACPI: Restrict program_hpx_type2() to AER bits

 drivers/pci/pci-acpi.c | 65 ++++++++++++++++++------------------------
 drivers/pci/pci.h      |  3 ++
 drivers/pci/pcie/aer.c |  3 --
 drivers/pci/probe.c    | 33 +++++++++++++++++++++
 4 files changed, 63 insertions(+), 41 deletions(-)

--
2.43.5


