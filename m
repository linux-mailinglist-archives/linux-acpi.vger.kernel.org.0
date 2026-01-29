Return-Path: <linux-acpi+bounces-20774-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FDgAZufe2nOGAIAu9opvQ
	(envelope-from <linux-acpi+bounces-20774-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 18:57:47 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E841B34D6
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 18:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A3D93030B2E
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 17:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BCF3563FA;
	Thu, 29 Jan 2026 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iqWD0PsN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033083563DA;
	Thu, 29 Jan 2026 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769709170; cv=none; b=l7kUQ172PRspC9L2Nm4eq5JZ61sQLztEZoZLll75V3bulcwgiJuqAfswqDg/CEgNixuer/yXKvapz2ggDv3eSAbv8/qbV3UIOOwpLPEIUy41O37gbv3kLtZG7vKbzBFgXfJz/FykwHOyGiZsOv2QyD+GAQfe4L/QXq23EHaWlvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769709170; c=relaxed/simple;
	bh=sDr4XFNxAHNhaLt8Ws9eC192yUNQjVcVEQ250Nx+eY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aD7V4rjoZDkTzdrl2cPBN6fb+TPANY6a6JLWATkUI7TC7fX44Gq892VuGQI003NWBIH4zTtP+D4gSdgTwQPvaCkKRjdWuIWb9YtwY7BeQHRVWFiZRNse4tgjBwMKD7Vcv0XpDJWucaGKRo5mJLXaq85d1Q6UU/Sl4KDOPtOfCCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iqWD0PsN; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TDgFJg676631;
	Thu, 29 Jan 2026 17:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1axu5SPP3Vc4eGTr+58LLjVYlrbFbUaeWx/m2sHFITk=; b=
	iqWD0PsN2rZ/RasGaywVmB3S6ybLnn+9ODV+gkxBQc7BIugJynDQ/615hhIYx12J
	BfxeCjD127FW/so7VrDcsbVA1gq/O1H8xg+1/Zybdu/ZU22h4P9irmfBQhlCBqx3
	XFDeMlzXHmJxGmveR6LNEJCNSCfeOS8T3oNPxlsofxfpJhLqD35r/ggL5IBxtNyh
	ShecUcNx163LKuwhnue25bOtUlhnNFjCxcI+LKzGmMoKtIPUXCDzRVZBe7oDw15P
	+8eIMrumkkyqaQwOsTXtDpXZBcO6DoYJJdyWM07U10Bfw1D7Fh09cnto+aYYSBYj
	v6q96FO9veDyvuiOIOdC7Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by2vgktas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 17:52:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60TGSbVM020001;
	Thu, 29 Jan 2026 17:52:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhhyfdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 17:52:42 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60THllYf012086;
	Thu, 29 Jan 2026 17:52:41 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4bvmhhyfc3-2;
	Thu, 29 Jan 2026 17:52:41 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Alex Williamson <alex@shazbot.org>,
        Johannes Thumshirn <morbidrsa@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
Subject: [PATCH v4 1/2] PCI: Initialize RCB from pci_configure_device()
Date: Thu, 29 Jan 2026 18:52:32 +0100
Message-ID: <20260129175237.727059-2-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260129175237.727059-1-haakon.bugge@oracle.com>
References: <20260129175237.727059-1-haakon.bugge@oracle.com>
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
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601290126
X-Proofpoint-GUID: lfcHnOq6APBM-SYcBRnPAJlbWewj5dWq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEyNiBTYWx0ZWRfX3cOWnU7SoH4c
 UixHRG4q9tnIlhn2aleG9x3gnr50A+2CEcyJf5CtIYdecKWzP3A2wTI6EEeIUtZCd2HlGm9hA1x
 /85Zh/vvuXQOjgU5JsCX40t/+qHvKdD77teYnUHoL4VPNd6xBgE9x/wF0s9jVDppG64ZHb4Ea8O
 e2MIfjyQhC9Np6lRArjPJGcWYuXYWo52JW0P3H/gkbF8myF4gG9Jw8xYKcSDStKa8GrdxieHe/O
 ASR0WzN9c6PjYjHHmWIeV9sdWim6wfCnQbMSGQWPnkbfdA7LrCUOvF5vqls2DSRqecLlg+bEOuv
 E49TLp6Ns1ivI7215f1Hn/gSezTjI8Kr94I9TWHJqRWAU/aRbu9QU2vEg6Pb2R2n4k1j2BlvRwJ
 LX/4UfNxbBfbYNeCmOEINoDwa8T1t9fkMOe7GZj6r0nFH2JEqDtejhVYtzjjXsVXrdXwTCEOdeV
 aBxogBuXY6SasCD1KgsigYJhUTSvGD/+WQW/1HmA=
X-Proofpoint-ORIG-GUID: lfcHnOq6APBM-SYcBRnPAJlbWewj5dWq
X-Authority-Analysis: v=2.4 cv=a7s9NESF c=1 sm=1 tr=0 ts=697b9e6b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=9d3epOvFGE0EtcMk89wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12103
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:dkim,oracle.com:mid];
	FREEMAIL_CC(0.00)[shazbot.org,gmail.com,vger.kernel.org,oracle.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20774-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haakon.bugge@oracle.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7E841B34D6
X-Rspamd-Action: no action

Commit e42010d8207f ("PCI: Set Read Completion Boundary to 128 iff
Root Port supports it (_HPX)") worked around a bogus _HPX type 2
record, which caused program_hpx_type2() to set the RCB in an endpoint
even though the Root Port did not have the RCB bit set.

e42010d8207f fixed that by setting the RCB in the endpoint only when
it was set in the Root Port.

In retrospect, program_hpx_type2() is intended for AER-related
settings, and the RCB should be configured elsewhere so it doesn't
depend on the presence or contents of an _HPX record.

Explicitly program the RCB from pci_configure_device() so it matches
the Root Port's RCB.  The Root Port may not be visible to virtualized
guests; in that case, leave RCB alone.

Fixes: Commit e42010d8207f ("PCI: Set Read Completion Boundary to 128 iff Root Port supports it (_HPX)")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

---

v3 -> v4:
   * Use open coding to read the Root Port's RCB
   * Remove info log

v2 -> v3:
   * Qualified the device types more strictly
   * s/pcie_root_rcb_set/pcie_read_root_rcb/ and changed signature
   * Do nothing if the RP's RCB cannot be determined
   * Reset the device's RCB if not set in the RP
---
 drivers/pci/probe.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 41183aed8f5d9..460f8af1c3429 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2410,6 +2410,38 @@ static void pci_configure_serr(struct pci_dev *dev)
 	}
 }
 
+static void pci_configure_rcb(struct pci_dev *dev)
+{
+	struct pci_dev *rp;
+	u16 rp_lnkctl;
+
+	/*
+	 * Per PCIe r7.0, sec 7.5.3.7, RCB is only meaningful in Root
+	 * Ports (where it is read-only), Endpoints, and Bridges.  It
+	 * may only be set for Endpoints and Bridges if it is set in
+	 * the Root Port. For Endpoints, it is 'RsvdP' for Virtual
+	 * Functions.
+	 */
+	if (!pci_is_pcie(dev) ||
+	    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+	    pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM ||
+	    pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
+	    pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC ||
+	    dev->is_virtfn)
+		return;
+
+	/* Root Port often not visible to virtualized guests */
+	rp = pcie_find_root_port(dev);
+	if (!rp)
+		return;
+
+	pcie_capability_read_word(rp, PCI_EXP_LNKCTL, &rp_lnkctl);
+	pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_RCB,
+					   (rp_lnkctl & PCI_EXP_LNKCTL_RCB) ?
+					   PCI_EXP_LNKCTL_RCB : 0);
+}
+
 static void pci_configure_device(struct pci_dev *dev)
 {
 	pci_configure_mps(dev);
@@ -2419,6 +2451,7 @@ static void pci_configure_device(struct pci_dev *dev)
 	pci_configure_aspm_l1ss(dev);
 	pci_configure_eetlp_prefix(dev);
 	pci_configure_serr(dev);
+	pci_configure_rcb(dev);
 
 	pci_acpi_program_hp_params(dev);
 }
-- 
2.43.5


