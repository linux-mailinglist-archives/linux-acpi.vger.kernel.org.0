Return-Path: <linux-acpi+bounces-12617-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE2AA7826A
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 20:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790C016A4AD
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 18:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A825D20FA96;
	Tue,  1 Apr 2025 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Sb7oSiKq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FA620D4F8;
	Tue,  1 Apr 2025 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743533175; cv=none; b=j/yHR1zW/MVSpQchAtell5lc9vkhfirXTqbDNV3JzLfe5lWZjDaGr2KaIg3oZECY1ly7GDwaKKuR8VqXOm+6sUqySY0dyRsL2s52OuBgcPBYC7AWrtgonBgM+3PL6Cj+B/bpL+tUStRLIYtGHPmEBK1NN0H8J+XvteVUlRgAuvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743533175; c=relaxed/simple;
	bh=HNhHH3uqWFzuN4oweVvGIWCxDu6KHeE/ZBo/2NlYHM8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KXBR6ejKVpi3vOyyC2SGKglvvjEIz2dmnOdddqoQ5/vKjVRsARFc6ea5pNo0nJ2dvI7WIg0zGMgEGWUN0aWg21w1xWvk+CV5RmZjDkIadsU0+Ct/7dWUKzuF3bsswCp2wBKd0W/y18Ido5OqNa6nDEr6BfUMLBh/JG02u9x5hSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=Sb7oSiKq; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:471f:0:640:4191:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 4D06560CC6;
	Tue,  1 Apr 2025 21:44:03 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown [2a02:6b8:b081:8129::1:28])
	by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id ahbvVD0FWa60-Ia69gsQe;
	Tue, 01 Apr 2025 21:44:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1743533042;
	bh=eMhHdCHA6bW4pvBztHIxttEiNTiHXzDH+rRdf/3ovTY=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=Sb7oSiKqPRy+5QUBsoMpQPI6aFkEdbRe3x2rHJXAMBHKVxSHwuaDX3HI6eQXd6t8a
	 82OWDFFjMKyQoBKWnv0vVTcXdmh44aXK3z4kq/paHA2EbyNwdeZqHcqtfaI7BhUYX4
	 VesJehXJqmax1SFtROc4C22CdR9HYkLLxceaKfnU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Robert Moore <robert.moore@intel.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPICA: exserial: don't forget to handle FFixedHW opregions for reading
Date: Tue,  1 Apr 2025 21:43:11 +0300
Message-Id: <20250401184312.599962-1-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initial commit that introduced support for FFixedHW operation
regions did add a special case in the AcpiExReadSerialBus If, but
forgot to actually handle it inside the switch, so add the missing case
to prevent reads from failing with AE_AML_INVALID_SPACE_ID.

Link: https://github.com/acpica/acpica/pull/998
Fixes: ee64b827a9a ("ACPICA: Add support for FFH Opregion special context data")
Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 drivers/acpi/acpica/exserial.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/acpica/exserial.c b/drivers/acpi/acpica/exserial.c
index 5241f4c01c76..89a4ac447a2b 100644
--- a/drivers/acpi/acpica/exserial.c
+++ b/drivers/acpi/acpica/exserial.c
@@ -201,6 +201,12 @@ acpi_ex_read_serial_bus(union acpi_operand_object *obj_desc,
 		function = ACPI_READ;
 		break;
 
+	case ACPI_ADR_SPACE_FIXED_HARDWARE:
+
+		buffer_length = ACPI_FFH_INPUT_BUFFER_SIZE;
+		function = ACPI_READ;
+		break;
+
 	default:
 		return_ACPI_STATUS(AE_AML_INVALID_SPACE_ID);
 	}
-- 
2.34.1


