Return-Path: <linux-acpi+bounces-20487-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPlAKVq7cGmWZQAAu9opvQ
	(envelope-from <linux-acpi+bounces-20487-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 12:41:14 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDD556256
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 12:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 69EA45A80F8
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 11:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383693EFD18;
	Wed, 21 Jan 2026 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PBkr25vc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7672F25E4;
	Wed, 21 Jan 2026 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768995355; cv=none; b=N4DR91zHfPAOTALUaE8CU02ZccTICYVbCnVvIHCB866OBW26EsBBWd5ngMn41wO6rhUVJ8neXw6S5YL6tzyW5ULIouL6pGTisDlZHEIOJkT8u7k+JttDRDG27ssZRx+viZxJpcTOEEhQFXBYq8y5imxbt4TlOIb+q3QCU+NfTqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768995355; c=relaxed/simple;
	bh=kSfF12lD1QRGjvmuKfHL67k399hEyUNjaJOzQoKoueQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5SyGPbfl+pgz3IYfE7ogIc1oft/Dme0et+wQ3QcMD4j655nncaOaT+WDMChzHEl5C0wNfaIqG3frZorrGztGxtt0KixZB4u4Tjw0JI16sc3IjUKilxKF1JnH+WiTue48gVGtmJFSLkPgL+KqQ7HmnSwm085Dg35qqhBmCJ/xS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PBkr25vc; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L3qGKl3028845;
	Wed, 21 Jan 2026 11:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=f1ruC/mJjX6MXwk7MDq2kfTBw2zOQyXEbPhWYQ6fM8E=; b=
	PBkr25vcBezK6XDRv8Ntyavrt4E7rb4r9rh+vNyrux5VWZn/bNwOU1/PiffXrrfK
	Dd5s5JENYtOQyNEsYj0mPzapKmBu5WSJBvBoqP7JAYhOwEV1fmLhsS+8pejphVQP
	yf5QaH0hBrayERQy1CcMlhiiqL41c7AB6B9/gM0N3cdKoSTM4fx9ONKHa7Kts0si
	8Nicf6X6RgmAFYjqMFReJ1AYLC+DL/etAtRtDZXhtl4xcIVt70nW2zs1PxMywnsr
	1NenaV9AaUeFNNXyFc3wKKk/458U8tzAaaW3XgWqx38NEcw37qVj8C6LxOTuM0N9
	sVhq6WXPnRHp1JOhFroUjQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br10vwpqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Jan 2026 11:35:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60LA6VPH018952;
	Wed, 21 Jan 2026 11:35:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bsyrry2u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Jan 2026 11:35:48 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60LBUlCB025086;
	Wed, 21 Jan 2026 11:35:48 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4bsyrry2rv-2;
	Wed, 21 Jan 2026 11:35:48 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Johannes Thumshirn <morbidrsa@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
Subject: [PATCH v2 1/2] PCI: Initialize RCB from pci_configure_device
Date: Wed, 21 Jan 2026 12:35:40 +0100
Message-ID: <20260121113544.4163457-2-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260121113544.4163457-1-haakon.bugge@oracle.com>
References: <20260121113544.4163457-1-haakon.bugge@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601210097
X-Authority-Analysis: v=2.4 cv=H4nWAuYi c=1 sm=1 tr=0 ts=6970ba15 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=wALBDtaT6Fz06Is1MRQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12104
X-Proofpoint-GUID: 2y_OOjaOQj-YhiQ-KTUgikTXTG-Q1gzN
X-Proofpoint-ORIG-GUID: 2y_OOjaOQj-YhiQ-KTUgikTXTG-Q1gzN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA5NyBTYWx0ZWRfXy/q95QTUvRlX
 +TSqaUAH3661QqPe2CHfLPOALcYssheX1dYMVDFUPmghHMB3F3bf0yzqzzcK+1iVB6im4RHU1AF
 VloADjrWaaJai/RUeqd24fSmwv8EqK4QZsXYO35XA5NZXPsv4+TAPlpK6dY6zYAJ69W1SyWferg
 kHFkC6TSInInrndpdWfcIU2Fqck72nzoROaH+iNzIey/0tXDloRFwxx6czSkN/CLbiZMdq5GYdd
 kdXD86AHvV8y2ylK8g0XLlAj6cUPPjdUNIpuuORptneph0ExTj8P31aTZ/iX2LbpiU9d9bp5jsS
 YgYha+mm9cyu1ilKfm4hDWIUxasy6t7TTPvcWKXWZU4nIreQV98zlNG+3r4gWG1z0CetbN6thOg
 g2tVrnigK8kC1pBQXqsUnehisoPr6U6BRGOHwUOuHL7uLypEAFzAzNZ+c8DH9oFjUnl/6kjxSRE
 2bhRSkr+101X97LPhprSpGIxbM7xSUORddd7QXjQ=
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20487-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,oracle.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,oracle.com:email,oracle.com:dkim,oracle.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[oracle.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[haakon.bugge@oracle.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8CDD556256
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit e42010d8207f ("PCI: Set Read Completion Boundary to 128 iff
Root Port supports it (_HPX)") fixed a bogus _HPX type 2 record, which
instructed program_hpx_type2() to set the RCB in an endpoint,
although it's RC did not have the RCB bit set.

e42010d8207f fixed that by qualifying the setting of the RCB in the
endpoint with the RC supporting an 128 byte RCB.

In retrospect, the program_hpx_type2() should only modify the AER
bits, and stay away from fiddling with the Link Control Register.

Hence, we explicitly program the RCB from pci_configure_device(). RCB
is RO in Root Ports, and in VFs, the bit is RsvdP, so for these two
cases we skip programming it. Then, if the Root Port has RCB set and
it is not set in the EP, we set it.

Fixes: Commit e42010d8207f ("PCI: Set Read Completion Boundary to 128 iff Root Port supports it (_HPX)")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

---

Note, that the current duplication of pcie_root_rcb_set() will be
removed in the next commit.
---
 drivers/pci/probe.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 41183aed8f5d9..347af29868124 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2410,6 +2410,41 @@ static void pci_configure_serr(struct pci_dev *dev)
 	}
 }
 
+static bool pcie_root_rcb_set(struct pci_dev *dev)
+{
+	struct pci_dev *rp = pcie_find_root_port(dev);
+	u16 lnkctl;
+
+	if (!rp)
+		return false;
+
+	pcie_capability_read_word(rp, PCI_EXP_LNKCTL, &lnkctl);
+
+	return !!(lnkctl & PCI_EXP_LNKCTL_RCB);
+}
+
+static void pci_configure_rcb(struct pci_dev *dev)
+{
+	/*
+	 * Obviously, we need a Link Control register. The RCB is RO
+	 * in Root Ports, so no need to attempt to set it for
+	 * them. For VFs, the RCB is RsvdP, so, no need to set it.
+	 * Then, if the Root Port has RCB set, then we set for the EP
+	 * unless already set.
+	 */
+	if (pcie_cap_has_lnkctl(dev) &&
+	    (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
+	    !dev->is_virtfn && pcie_root_rcb_set(dev)) {
+		u16 lnkctl;
+
+		pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
+		if (lnkctl & PCI_EXP_LNKCTL_RCB)
+			return;
+
+		pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnkctl | PCI_EXP_LNKCTL_RCB);
+	}
+}
+
 static void pci_configure_device(struct pci_dev *dev)
 {
 	pci_configure_mps(dev);
@@ -2419,6 +2454,7 @@ static void pci_configure_device(struct pci_dev *dev)
 	pci_configure_aspm_l1ss(dev);
 	pci_configure_eetlp_prefix(dev);
 	pci_configure_serr(dev);
+	pci_configure_rcb(dev);
 
 	pci_acpi_program_hp_params(dev);
 }
-- 
2.43.5


