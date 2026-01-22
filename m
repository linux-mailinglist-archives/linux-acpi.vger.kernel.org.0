Return-Path: <linux-acpi+bounces-20549-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJVnNU0mcmkVdwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20549-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 14:29:49 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBF4674A2
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 14:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 155D696A031
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 13:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED2B3033CD;
	Thu, 22 Jan 2026 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FU5mhgYk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABAA30EF96;
	Thu, 22 Jan 2026 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769087429; cv=none; b=acTttDdRoEjb/JHUdBj9DgHHCiIQNywUIUKvrmyCCjrAGQzgq7saCzcehTKOyWolCcEkQGbtSj24ZkQ9KHjk4T+P5Fob+b72BXEOS60Cx4+WbWxwLtuQLBgNHvdSpPu955CphlHTDLwVdEKYUq5f0avwvM5Jg2HeSp10wU8OvnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769087429; c=relaxed/simple;
	bh=F13J/FbLU4ABrtTRpAA49+xEX8MM+pBTbh4xYEkufAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t7edkLJRb19VRLxuUtYAfpGw0B7graIUg9ypokJGJe6x8oa9Ujv5RFo5HRrbPQr5EOwjuRJEv8lyt0bGJTMNGvSoDJVeogAnJlvYogOZRPofmXRTfkwmuQwNyJkZpYpLDzwJNrQz5FaUJloYvkJ/g20LhMoCmSqbFZuo2+k4CB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FU5mhgYk; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M0lgCY3264931;
	Thu, 22 Jan 2026 13:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oRfm02u+temvz2ujx0ebpNSlErZspvbq1k+jkRcQ3Ag=; b=
	FU5mhgYkfh7m1iSQ2ZliSVebTRhT91VR1Hh3kOGZrWYws6+6C4V3a1gOPOnWxiwl
	xOcJM3JNoGOqg9ZSwm/+P8MiTCQIKURcHmhEzdju6TaXyJVomaktPDlK9XVoz6fW
	HsaPY/gFJDQ1AbZs4mBu2hrqjdzvH0JjBUWVVezHdmCTcVaMYTe4tj1wAMiCsqJD
	wPGxIisHrlmvASmQAu1fqr4UYl52UdOgESWD08JY6maHLyXEErs+WDhQ5rAxeDFk
	pP+VFNIAO0cVX3/IF0AEKuYupThd8l0P6Axsdsah9bp9cgexww0B2rRAjflp69uE
	LFHNdHkPPsCPdCp8MG62BQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br1b8fpjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 13:10:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MCJtgA015534;
	Thu, 22 Jan 2026 13:10:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vctgsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 13:10:08 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60MD5mR1028904;
	Thu, 22 Jan 2026 13:10:08 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4br0vctgdy-2;
	Thu, 22 Jan 2026 13:10:07 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Alex Williamson <alex@shazbot.org>,
        Johannes Thumshirn <morbidrsa@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
Subject: [PATCH v3 1/2] PCI: Initialize RCB from pci_configure_device
Date: Thu, 22 Jan 2026 14:09:53 +0100
Message-ID: <20260122130957.68757-2-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260122130957.68757-1-haakon.bugge@oracle.com>
References: <20260122130957.68757-1-haakon.bugge@oracle.com>
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
 definitions=2026-01-22_01,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220098
X-Authority-Analysis: v=2.4 cv=WbcBqkhX c=1 sm=1 tr=0 ts=697221b1 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=W2A6FuTIenI3-7UfN4cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA5NiBTYWx0ZWRfX9Zv0iJEXua69
 XsTcmh7/xN2JHZWYukSzDO6a9FeVbC8qiULZqEGTN8z1Um4KUtH6BwbFKc3d1qJchWCxTDOWO34
 IS4AVTLs/KhDfNg16zy5BB5bXcMOicUtZemZe0k4p9cb4RAbR4FoD57ABXzcm8HPS6H0VL0jlO9
 cnt+E6/6P9DOOu8jxobMQpD6spRJZFRWnmCJmfuNh8YS2JABKS5oaT3qjhqd/urqd/6g1dVK6+U
 DIVmhNpNZyJub+XrtEWAzFVdK6g7lu+QwXe2EX4IU9pYLZNVMCZqafUCFXK23JejcxN/Dih1J/3
 opNwj68pUIEkDOktDUKPKhva9U5W/tOVjavNNP+603l3IcrnXRIgaxgIWdi5UJi2xA7qW6H3INJ
 PtJH+Iuh+uoTOkTBNfmjhJp/P8fFSVvIzR7jGbVdmyJq3AfwZNmoyxX+qLycf+i8XjFHIoeO8WJ
 6oK5I7zRG5HFeSakWjQ==
X-Proofpoint-ORIG-GUID: dB5tjO8ckOFC4v1NywuNKUe-CkPlAMXB
X-Proofpoint-GUID: dB5tjO8ckOFC4v1NywuNKUe-CkPlAMXB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[shazbot.org,gmail.com,vger.kernel.org,oracle.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20549-lists,linux-acpi=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[oracle.com,reject];
	DKIM_TRACE(0.00)[oracle.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haakon.bugge@oracle.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4CBF4674A2
X-Rspamd-Action: no action

Commit e42010d8207f ("PCI: Set Read Completion Boundary to 128 iff
Root Port supports it (_HPX)") fixed a bogus _HPX type 2 record, which
instructed program_hpx_type2() to set the RCB in an endpoint,
although it's RC did not have the RCB bit set.

e42010d8207f fixed that by qualifying the setting of the RCB in the
endpoint with the RC supporting an 128 byte RCB.

In retrospect, the program_hpx_type2() should only modify the AER
bits, and stay away from fiddling with the Link Control Register.

Hence, we explicitly program the RCB from pci_configure_device().

According to PCIe r7.0, sec 7.5.3.7, RCB is only valid for Root Ports
(where it is Read-Only), Bridges, and Endpoints. The bit is 'RsvdP'
for Virtual Functions. Hence, for other cases than Bridges and Physical
Endpoints, we bail out early from pci_configure_rcb().

If the Root Port's RCB cannot be determined, we do nothing.

If RCB is set in the Root Port and not in the device, we set it. If it
is set in the device but not in the Root Port, we print an info
message and reset it.

Fixes: Commit e42010d8207f ("PCI: Set Read Completion Boundary to 128 iff Root Port supports it (_HPX)")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

---

Note, that the current duplication of pcie_root_rcb_set() will be
removed in the next commit.

v2 -> v3:
   * Qualified the device types more strictly
   * s/pcie_root_rcb_set/pcie_read_root_rcb/ and changed signature
   * Do nothing if the RP's RCB cannot be determined
   * Reset the device's RCB if not set in the RP
---
 drivers/pci/probe.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 41183aed8f5d9..7165ac4065c97 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2410,6 +2410,58 @@ static void pci_configure_serr(struct pci_dev *dev)
 	}
 }
 
+static bool pcie_read_root_rcb(struct pci_dev *dev, bool *rcb)
+{
+	struct pci_dev *rp = pcie_find_root_port(dev);
+	u16 lnkctl;
+
+	if (!rp)
+		return false;
+
+	pcie_capability_read_word(rp, PCI_EXP_LNKCTL, &lnkctl);
+
+	*rcb = !!(lnkctl & PCI_EXP_LNKCTL_RCB);
+	return true;
+}
+
+static void pci_configure_rcb(struct pci_dev *dev)
+{
+	u16 lnkctl;
+	bool rcb;
+
+	/*
+	 * Per PCIe r7.0, sec 7.5.3.7, RCB is only meaningful in Root
+	 * Ports (where it is read-only), Endpoints, and Bridges.  It
+	 * may only be set for Endpoints and Bridges if it is set in
+	 * the Root Port. For Endpoints, it is 'RsvdP' for Virtual
+	 * Functions. If the Root Port's RCB cannot be determined, we
+	 * bail out.
+	 */
+	if (!pci_is_pcie(dev) ||
+	    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+	    pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM ||
+	    pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
+	    pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC ||
+	    dev->is_virtfn || !pcie_read_root_rcb(dev, &rcb))
+		return;
+
+	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
+	if (rcb) {
+		if (lnkctl & PCI_EXP_LNKCTL_RCB)
+			return;
+
+		lnkctl |= PCI_EXP_LNKCTL_RCB;
+	} else {
+		if (!(lnkctl & PCI_EXP_LNKCTL_RCB))
+			return;
+
+		pci_info(dev, FW_INFO "clearing RCB (RCB not set in Root Port)\n");
+		lnkctl &= ~PCI_EXP_LNKCTL_RCB;
+	}
+
+	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnkctl);
+}
+
 static void pci_configure_device(struct pci_dev *dev)
 {
 	pci_configure_mps(dev);
@@ -2419,6 +2471,7 @@ static void pci_configure_device(struct pci_dev *dev)
 	pci_configure_aspm_l1ss(dev);
 	pci_configure_eetlp_prefix(dev);
 	pci_configure_serr(dev);
+	pci_configure_rcb(dev);
 
 	pci_acpi_program_hp_params(dev);
 }
-- 
2.43.5


