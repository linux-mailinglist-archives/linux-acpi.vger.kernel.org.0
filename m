Return-Path: <linux-acpi+bounces-20488-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iE4tJMW8cGkRZgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20488-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 12:47:17 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2241F5634E
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 12:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 590DB989A8A
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 11:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1740540B6E6;
	Wed, 21 Jan 2026 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MOnnSka8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B7940B6E4;
	Wed, 21 Jan 2026 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768995381; cv=none; b=aFce+Ye3MoYlhJfPrcfP5TQ2WEOcE9stFAGLpeWu4FIfFA6RQGfxWfG6DgQTc7IAoozXVqO9m8hWDrXFaps4GH6qrmLp7z0JevyZ88l1MHo3A0C3Pkl6MPupRZ3M4nIfOO+PCbfw7jaqHeGEzb6GoVMYOIeLbObonQNyelutddU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768995381; c=relaxed/simple;
	bh=mSmsMtvGwq1jQxsB6FlcxVipMrAkvxQnT9An0dZtQ0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVQYWyA9c2fATUHhDnYih1P811QsGDhRpFrHN/9Z62F5iRuzSQIYNZaSpFCw0m7ufNs81dlwNmIOX+yFzSjLb3czCkgKpvcyJOjXH8Y9TLava/ylcg8LhDmGqYW9TuYTWeOVkdpbotNnvUrC/r2HpqpwvkW9qeSNj6lsVlKgQi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MOnnSka8; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L5DAob3264903;
	Wed, 21 Jan 2026 11:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8xSmsePBtJ3EW+zKnS0O0ktRO+JFCw7jsgeeT4kz2Qw=; b=
	MOnnSka8xoIYh/B6oQ1Uphz72FGG+D8EnlDjAb3NBGkkGFD4nuVoeBlraSbBGhPX
	9h3UwXuM/47qBP7FGg42txUJEogNnBjquRqynSuYafsOxNWYpU0cpt3kP132CA6P
	pxSm9CN/Gy+/oeiP+MzDimcOCB2r2JEolo2yMN2mjjTjUBuUgh6PbV1hgbjwxWIi
	+T5QonDVTGQN+IF3Su/pFTB/ypCUh3fhYi4zC1zWNne3bgd00Tw23PqqZD8dS9z4
	UNpn7cJuS34ZkvO8GbH5SSlqj3Vj3HYgXMwGxeEf/Ofq28+4diKjADDnF4nwU89u
	nAhnfgtdsRCQ1nzRBeRJfw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br1b8dq1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Jan 2026 11:35:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60LA6OqX019001;
	Wed, 21 Jan 2026 11:35:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bsyrry2x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Jan 2026 11:35:52 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60LBUlCD025086;
	Wed, 21 Jan 2026 11:35:52 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4bsyrry2rv-3;
	Wed, 21 Jan 2026 11:35:51 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Johannes Thumshirn <morbidrsa@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/2] PCI/ACPI: Confine program_hpx_type2 to the AER bits
Date: Wed, 21 Jan 2026 12:35:41 +0100
Message-ID: <20260121113544.4163457-3-haakon.bugge@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=WbcBqkhX c=1 sm=1 tr=0 ts=6970ba19 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=CF6WusRKGoJ8OkfercgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12104
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA5NyBTYWx0ZWRfX9XpsfvLL6NYD
 Uk+YDRag+k2Ud1sE/a096WHh6+TxZ06Cg7PO04mKuliheJH5enV0iCXCsAj6TQwzwjnEi2o2aI5
 JGBih8zwIEE1nKTNDHf1huTMFgQNqRuZFclwJIQuHk9OXI0acADnseIXsfESABLSbiES5sdtH0m
 N+GNIPP5XDHroUnAYzBQm0kxTmAlX+Y1nrF1vbY8qKAsi65h/K0my5JJDMNuZv86nK+zqRgrwNu
 FttEOly85PD+ofOtX0pNCDIcysRetxzTPkr7BPK75Y+Zk93eWU8IpHgNOX0pOAFmdHH4pmTWY3r
 576sogZHVRM3reU4OwS+SwUjscYoFMvIX/gJRsAy65oIGwicD9cmARfbn3SlszdyJJl1JGvoiCN
 TBCsFeXEOg7DEq5pM2ZvxshTCHZooskdankMJ/Br/VaYLL8F1h1stxvTkiuSuOHC1PxhTCK1xzJ
 QeL6YJQ5NDZTcSNI4yTGznP3MB11R0u2DB4/6AZ8=
X-Proofpoint-ORIG-GUID: JGxWucj1N6acwkaAvfRYpRanyfa6x2xv
X-Proofpoint-GUID: JGxWucj1N6acwkaAvfRYpRanyfa6x2xv
X-Spamd-Result: default: False [-0.96 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-20488-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,kernel.org,linux.ibm.com,gmail.com,suse.de,jp.fujitsu.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,oracle.com,lists.ozlabs.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haakon.bugge@oracle.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[oracle.com,reject];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2241F5634E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

program_hpx_type2() is today unconditionally called, despite the fact
that when the _HPX was added to the ACPI spec. v3.0, the description
stated:

 OSPM [1] will only evaluate _HPX with Setting Record – Type 2 if OSPM
 is not controlling the PCI Express Advanced Error Reporting
 capability.

Hence, we only call program_hpx_type2() when the OSPM owns the PCIe
hotplug capability but not the AER.

The Advanced Configuration and Power Interface (ACPI) Specification
version 6.6 has a provision that gives the OSPM the ability to control
the other PCIe Device Control bits any way. In a note in section
6.2.9, it is stated:

"OSPM may override the settings provided by the _HPX object's Type2
record (PCI Express Settings) or Type3 record (PCI Express Descriptor
Settings) when OSPM has assumed native control of the corresponding
feature."

So, in order to preserve the non-AER bits in PCIe Device Control, in
particular the performance sensitive ExtTag and RO, we make sure
program_hpx_type2() if called, doesn't modify any non-AER bits.

Also, when program_hpx_type2() is called, we completely avoid
modifying any bits in the Link Control register. However, if the _HPX
type 2 records contains bits indicating such modifications, we print
an info message.

[1] Operating System-directed configuration and Power Management

Fixes: 40abb96c51bb ("[PATCH] pciehp: Fix programming hotplug parameters")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

---

v1 -> v2:
   * Fixed comment style
   * Simplified the and/or logic when programming the Device Control
     register
   * Fixed the incorrect and brutal warning about Link Control
     register bits set and changed it to an info message about _HPX
     attempting to set/reset bits therein.
   * Removed the RCB programming from program_hpx_type2()
   * Moved the PCI_EXP_AER_FLAGS definition from
     drivers/pci/pcie/aer.c to drivers/pci/pci.h
---
 drivers/pci/pci-acpi.c | 61 +++++++++++++++++++-----------------------
 drivers/pci/pci.h      |  3 +++
 drivers/pci/pcie/aer.c |  3 ---
 3 files changed, 30 insertions(+), 37 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 9369377725fa0..34ea22f65a410 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -271,21 +271,6 @@ static acpi_status decode_type1_hpx_record(union acpi_object *record,
 	return AE_OK;
 }
 
-static bool pcie_root_rcb_set(struct pci_dev *dev)
-{
-	struct pci_dev *rp = pcie_find_root_port(dev);
-	u16 lnkctl;
-
-	if (!rp)
-		return false;
-
-	pcie_capability_read_word(rp, PCI_EXP_LNKCTL, &lnkctl);
-	if (lnkctl & PCI_EXP_LNKCTL_RCB)
-		return true;
-
-	return false;
-}
-
 /* _HPX PCI Express Setting Record (Type 2) */
 struct hpx_type2 {
 	u32 revision;
@@ -311,6 +296,7 @@ static void program_hpx_type2(struct pci_dev *dev, struct hpx_type2 *hpx)
 {
 	int pos;
 	u32 reg32;
+	const struct pci_host_bridge *host;
 
 	if (!hpx)
 		return;
@@ -318,6 +304,15 @@ static void program_hpx_type2(struct pci_dev *dev, struct hpx_type2 *hpx)
 	if (!pci_is_pcie(dev))
 		return;
 
+	host = pci_find_host_bridge(dev->bus);
+
+	/*
+	 * We only do the HP programming if we own the PCIe native
+	 * hotplug and not the AER ownership
+	 */
+	if (!host->native_pcie_hotplug || host->native_aer)
+		return;
+
 	if (hpx->revision > 1) {
 		pci_warn(dev, "PCIe settings rev %d not supported\n",
 			 hpx->revision);
@@ -325,33 +320,31 @@ static void program_hpx_type2(struct pci_dev *dev, struct hpx_type2 *hpx)
 	}
 
 	/*
-	 * Don't allow _HPX to change MPS or MRRS settings.  We manage
-	 * those to make sure they're consistent with the rest of the
+	 * We only allow _HPX to program the AER registers, namely
+	 * PCI_EXP_DEVCTL_CERE, PCI_EXP_DEVCTL_NFERE,
+	 * PCI_EXP_DEVCTL_FERE, and PCI_EXP_DEVCTL_URRE.
+	 *
+	 * The other settings in PCIe DEVCTL are managed by OS in
+	 * order to make sure they're consistent with the rest of the
 	 * platform.
 	 */
-	hpx->pci_exp_devctl_and |= PCI_EXP_DEVCTL_PAYLOAD |
-				    PCI_EXP_DEVCTL_READRQ;
-	hpx->pci_exp_devctl_or &= ~(PCI_EXP_DEVCTL_PAYLOAD |
-				    PCI_EXP_DEVCTL_READRQ);
+	hpx->pci_exp_devctl_and |= ~PCI_EXP_AER_FLAGS;
+	hpx->pci_exp_devctl_or &= PCI_EXP_AER_FLAGS;
 
 	/* Initialize Device Control Register */
 	pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
 			~hpx->pci_exp_devctl_and, hpx->pci_exp_devctl_or);
 
-	/* Initialize Link Control Register */
+	/* Log if _HPX attempts to modify PCIe Link Control register */
 	if (pcie_cap_has_lnkctl(dev)) {
-
-		/*
-		 * If the Root Port supports Read Completion Boundary of
-		 * 128, set RCB to 128.  Otherwise, clear it.
-		 */
-		hpx->pci_exp_lnkctl_and |= PCI_EXP_LNKCTL_RCB;
-		hpx->pci_exp_lnkctl_or &= ~PCI_EXP_LNKCTL_RCB;
-		if (pcie_root_rcb_set(dev))
-			hpx->pci_exp_lnkctl_or |= PCI_EXP_LNKCTL_RCB;
-
-		pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
-			~hpx->pci_exp_lnkctl_and, hpx->pci_exp_lnkctl_or);
+		if (hpx->pci_exp_lnkctl_and)
+			pci_info(dev,
+				 "_HPX attempts to reset the following bits in PCIe Link Control: 0x%04x\n",
+				 hpx->pci_exp_lnkctl_and);
+		if (hpx->pci_exp_lnkctl_or)
+			pci_info(dev,
+				 "_HPX attempts to set the following bits in PCIe Link Control: 0x%04x\n",
+				 hpx->pci_exp_lnkctl_or);
 	}
 
 	/* Find Advanced Error Reporting Enhanced Capability */
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0e67014aa0013..f388d4414dd3a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -88,6 +88,9 @@ struct pcie_tlp_log;
 #define PCI_BUS_BRIDGE_MEM_WINDOW	1
 #define PCI_BUS_BRIDGE_PREF_MEM_WINDOW	2
 
+#define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
+				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e0bcaa896803c..9472d86cef552 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -239,9 +239,6 @@ void pcie_ecrc_get_policy(char *str)
 }
 #endif	/* CONFIG_PCIE_ECRC */
 
-#define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
-				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
-
 int pcie_aer_is_native(struct pci_dev *dev)
 {
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
-- 
2.43.5


