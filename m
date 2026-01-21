Return-Path: <linux-acpi+bounces-20484-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yN/sAQiUcGlyYgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20484-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 09:53:28 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E7C53E96
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 09:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A3E4563AB7
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 08:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01701427A0F;
	Wed, 21 Jan 2026 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cp1E3dao"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815A336657B;
	Wed, 21 Jan 2026 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768985472; cv=none; b=WbXSzl9fHUff0AHmsPjAAFJW8LctO8KOISnIy/6JDWpRRs7V/5oTM+Hv84+OPbcQTb1WfK+ixOCApcpxAcYKhcSpSjM0/qDBzYbUc7ZQCU5i1XwjV6AbzzPWjF5TZ8J1pLfnhhK0m87MBO4xC/wwz+1nN6kT09Tbgf+TT0s5JNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768985472; c=relaxed/simple;
	bh=0p7FqrGTHaYbu4QmCQP4AVNn9vlQWfjeboAHFDbfH9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qxre0aD/yNogW8grdWGun+KYbcR6tWOYqiez6TLVtyIAY1U4ooLumdf22alNWYyTvB86lf3FdUnjkVQPduKgGy9zcVckcARrQ6U6PCaS098UxUFrbJX/KYyivHFQeU+2Nrb8wbq4sx2AYgSwbAcEuKFDvW1JOgdaZuGlN58OWZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cp1E3dao; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768985471; x=1800521471;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0p7FqrGTHaYbu4QmCQP4AVNn9vlQWfjeboAHFDbfH9I=;
  b=cp1E3dao7b/SrWZQzTlRCtnK9XiJuJHte3YkoRwj3ITXZfeJV9MtQtzv
   kfkrSuGH7FWMnC6UBDnJexq5WM3dH+p/u6EM1YlVO6NcRpgoNIgzJrNDt
   WsOuh+F0fYpXXQLVQcxfxfCR3/ZJgeIAvRQ+Qy89jUm+Nwq4dOthfA3B6
   GOEEBJ8lQrzDkEfC6b/cPeB6SrR8gWZ+zNNhTevq404FIewtXDy5aS8hT
   F/sHPHrB6C0ZC/Kyq/DjXWWVW/6LM5cKMNKnhMw6zUH3ZR1CwtbM0QWPU
   mlP5o6Cllo3dZI54nvNoP7LXCrVuTB+4Vel9tjCVXgMstkC4U9wmfIu2m
   A==;
X-CSE-ConnectionGUID: iS/kbFdOQO6iLMHoDnj8+Q==
X-CSE-MsgGUID: EZ6UgdGoSOqSxmqaPXW/Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="80927323"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="80927323"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 00:51:10 -0800
X-CSE-ConnectionGUID: XYlX7UYzRNq8Lx9XYIiDnA==
X-CSE-MsgGUID: D1H+aY1mRB6jTBnGcFCTrQ==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 21 Jan 2026 00:51:08 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4296898; Wed, 21 Jan 2026 09:51:07 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v2 1/1] ACPI: PCI: simplify code with acpi_get_local_u64_address()
Date: Wed, 21 Jan 2026 09:50:49 +0100
Message-ID: <20260121085105.2282380-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-20484-lists,linux-acpi=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-acpi];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.intel.com:mid]
X-Rspamd-Queue-Id: 61E7C53E96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now we have a helper so there's no need to open-code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: fixed a typo (LKP)

 drivers/acpi/pci_slot.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/pci_slot.c b/drivers/acpi/pci_slot.c
index 741bcc9d6d6a..15234b65ea22 100644
--- a/drivers/acpi/pci_slot.c
+++ b/drivers/acpi/pci_slot.c
@@ -42,8 +42,9 @@ static int
 check_slot(acpi_handle handle, unsigned long long *sun)
 {
 	int device = -1;
-	unsigned long long adr, sta;
+	unsigned long long sta;
 	acpi_status status;
+	u64 adr;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
 	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
@@ -56,10 +57,9 @@ check_slot(acpi_handle handle, unsigned long long *sun)
 			goto out;
 	}
 
-	status = acpi_evaluate_integer(handle, "_ADR", NULL, &adr);
-	if (ACPI_FAILURE(status)) {
-		pr_debug("_ADR returned %d on %s\n",
-			 status, (char *)buffer.pointer);
+	if (acpi_get_local_u64_address(handle, &adr)) {
+		pr_debug("_ADR returned with failure on %s\n",
+			 (char *)buffer.pointer);
 		goto out;
 	}
 
-- 
2.50.1


