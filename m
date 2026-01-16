Return-Path: <linux-acpi+bounces-20402-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C16D32672
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jan 2026 15:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70B7A302A978
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jan 2026 14:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B3D283FFB;
	Fri, 16 Jan 2026 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZktaIa27"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36C519AD5C;
	Fri, 16 Jan 2026 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768572473; cv=none; b=TXKW2pGzzbM3YszAv0iA88PQNCANrZhlCNMJcZN9ymSGtKDg+X5t66MWMSvzQ81/JB9DMv3mW3IrQabUsobEyvCWeY9ngt2DdxtRh+k+/ps6JulrY/9fzjI/xhmtFnztwqHSk+4C4/akWNoorNNSaEDrOpsLrqC2oGIOIDiri2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768572473; c=relaxed/simple;
	bh=eapDR7Fiku9DAgANS8q4KICYHlZJQrVNU7ACVjQ8crg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MI71PbD3+nvkVyKo+Yzxa0f1mo6rSMLPe14jk5DKfxGz5YHDk7pc+3YPuj47sW2mjQNmrDtRaPFLumlV2aXCcXbbevpue2aAsyhy7X3ugNQQ0RELuZGh61s3pWyGHJWUx0PMWAhPlFLgC+myaCRH0Vl0/pt45dRcqa2E29B4hSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZktaIa27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26215C116C6;
	Fri, 16 Jan 2026 14:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768572473;
	bh=eapDR7Fiku9DAgANS8q4KICYHlZJQrVNU7ACVjQ8crg=;
	h=From:Date:Subject:To:Cc:From;
	b=ZktaIa27Pwx1ZVigKY9j03yCEeYYwraKkGm5HMy5wgXq/c3nyVLCStJx/cgojGrdx
	 Bq7r6Eazv+uwNgpPn3Ajsf94Vhnws0gMDWm+ziJidJMYRzOPx/h/RkVILw8njZl0cn
	 /m7grO6t8JInbhl7J0g9YNyTFX//8aJF42mk4QIrDtpv0/e1ketdOe2fA6ekm+AMla
	 bf4niqKj3X2II1l7iW00RgyCRuCayzpHhl4NDhlsPuZKGWmDhA7FEaSRs0k63S3bod
	 nC2eiJsYJLdiKyPXra3IV+ROZ68dP5KqdKArVUqzgc14h9agS7UK0A0ZvuVell6NdX
	 9u8oIlw8OqN4g==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 16 Jan 2026 14:07:40 +0000
Subject: [PATCH] mailbox: pcc: Remove spurious IRQF_ONESHOT usage
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-mailbox-pcc-non-threaded-irq-v1-1-916b093329cd@kernel.org>
X-B4-Tracking: v=1; b=H4sIACxGamkC/yXMwQrCMAwA0F8ZORtoKhvor4iHLs1cRNuZThmM/
 bt1Ht/lrVDEVAqcmxVMPlo0pwo6NMBjSDdBjdXgne8cUYvPoI8+LzgxY8oJ59EkRImo9kLi4E/
 dkcS1BLWYTAZd9v5y/bu8+7vw/Dth2773XqEegAAAAA==
X-Change-ID: 20260115-mailbox-pcc-non-threaded-irq-1ca29631e051
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>
Cc: Aishwarya TCV <Aishwarya.TCV@arm.com>, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1300; i=broonie@kernel.org;
 h=from:subject:message-id; bh=eapDR7Fiku9DAgANS8q4KICYHlZJQrVNU7ACVjQ8crg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpakY37nNngFmII63IJoMuFzEG8RVbUnOBeWq+z
 HOVxCFlVpqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaWpGNwAKCRAk1otyXVSH
 0LgOB/9VP2w4vZa0eV0fskCdzsXJYwqowFHxJc+huh8yvNLMaK7Bo1BJp4E18M6kbyvsQttJyZ5
 haNQdCwPMcfF+dDvydAoOxgq4wca9PGSgRLs8sypRXPbe8ccvuGasbJBGHmVweMe1HciCFbY+eZ
 42n/mPUP7FigydWyfvM8fYHhwlvZgtDL11di/6PCNU4UfC/uV12LBABBlWkspLJScIlnnlWQHVx
 menXKrJlYqgQU8ZGh04fPftV91w6soeAfYD//15t7sXTdoi6lna5EgWaqxfr61NFIaVI3L56TUU
 DbLWWQJQF0HjqWNkuNVpoJnUXOi+jDDpAmQj5sfgTBUGxfYs
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The PCC code currently specifies IRQF_ONESHOT if the interrupt could
potentially be shared but doesn't actually use request_threaded_irq() and
the interrupt handler does not use IRQ_WAKE_THREAD so IRQF_ONESHOT is
never relevant. Since commit aef30c8d569c ("genirq: Warn about using
IRQF_ONESHOT without a threaded handler") specifying it has resulted in a
WARN_ON(), fix this by removing IRQF_ONESHOT.

Reported-by: Aishwarya TCV <Aishwarya.TCV@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/mailbox/pcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index ff292b9e0be9..060489e5ae6d 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -552,7 +552,7 @@ static int pcc_startup(struct mbox_chan *chan)
 
 	if (pchan->plat_irq > 0) {
 		irqflags = pcc_chan_plat_irq_can_be_shared(pchan) ?
-						IRQF_SHARED | IRQF_ONESHOT : 0;
+						IRQF_SHARED : 0;
 		rc = devm_request_irq(chan->mbox->dev, pchan->plat_irq, pcc_mbox_irq,
 				      irqflags, MBOX_IRQ_NAME, chan);
 		if (unlikely(rc)) {

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260115-mailbox-pcc-non-threaded-irq-1ca29631e051

Best regards,
--  
Mark Brown <broonie@kernel.org>


