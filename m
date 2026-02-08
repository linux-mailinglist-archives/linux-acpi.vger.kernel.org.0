Return-Path: <linux-acpi+bounces-20896-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNvWJjcLiGmyhgQAu9opvQ
	(envelope-from <linux-acpi+bounces-20896-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 08 Feb 2026 05:04:07 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF79107C8F
	for <lists+linux-acpi@lfdr.de>; Sun, 08 Feb 2026 05:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F3283013260
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Feb 2026 04:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656E12C21D8;
	Sun,  8 Feb 2026 04:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P7qE1WmT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E3A26461F
	for <linux-acpi@vger.kernel.org>; Sun,  8 Feb 2026 04:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770523443; cv=none; b=k/5noL4CZfv1o90k7fKBqddGzLXCVNqooyp1WL5bRqmr5bVdHNmavxwIkI3o057pbJtEwQDcO5G8ITheD1YiaOIIvsAZ8pEq19ZrMAuMyEgQWixSXHW8uVNkrkjWtMf4ghln50mwhV9ywpp1Spi/bbi6+8QLbsl3uTyYOrV0U3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770523443; c=relaxed/simple;
	bh=gVLYpM9coDM1ziPBdzZCYGdJwdE7dELsKzKbZ2xsotU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ibZKX1Eo/63syKK1FnxVjTcF5d5d+pSq8B1HnaryCjTDsdQEVmqDTWkqnOupf2VSDhGfDbKKM+/qxAmbbU1uvneEvQKLtbiU8Qd5L8qUYq6LlPht2ikODqvacqdbXSEy/U6P7RusHjz9rBRpKs90pbEcGWDURuyoAxcu6seI8sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P7qE1WmT; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1270adc5121so1642066c88.0
        for <linux-acpi@vger.kernel.org>; Sat, 07 Feb 2026 20:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1770523442; x=1771128242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oUKaI1Jl6BOBoZBMk5DmhJ8i+x4ONVWqzInJUK5fe+o=;
        b=P7qE1WmTEd5I37fInOyQx1w45mjLTo3qys+INfnu8t5IC9k+n6eN+ZAZ3b87UDXN2R
         v1vJuuW32wtajMDyRxLYu5uO5V3+NEqo2KKby93w25FfGf47VyoRpWyBNa5sxkx60LU+
         stMtq3lODGpYytxQofsfgc5yc+ToC+xJyk3qI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770523442; x=1771128242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUKaI1Jl6BOBoZBMk5DmhJ8i+x4ONVWqzInJUK5fe+o=;
        b=L+ZB9/m3jaFVtiz8eXSgrAkaSgEsVNldWiXbGfg2bym2/YO72uCR4yS64zhCS66PEq
         LdT4VhgWJxEPFzPBucu+LEp2hulQEQvHkSL59I+evDgNa5PWOvDXKPbxw22CoP9HKkun
         4eK0DcqiGEwhHAuwTxQUouSJKvocKB8Q8OcXbf7Eyvx+2Hg1L4YsgXB5hCmmWNAI/PME
         3cBNL3D5ace5yToOt42lIay5ohFDtkkkJJ5f0sgoSyquck7P9l+KBGrhj+WtsfxtYB62
         xo4DezIPypVVF3BFAAgjKsjwfI2FzTCCoPUUyNuuJnqe/+T8GvPoLdllwHehk2cjy4Cl
         ZAHw==
X-Forwarded-Encrypted: i=1; AJvYcCV9eaCwPGH/n9jXlftv3FGgjGiUBT8IlD5ZzKYH8FjdNys0vip5Pn2FuzCdkILQoCyQuRGY3UvWhoRT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+eVXEkKfEQRVyCq/oi/Juz8nPW3RN+bEhyMeCMJI7I5xfdaIE
	wtDcbQ7Yk5THA13xbz72bTwH2sojHdJXfGRY8x5nKcU+DUlZRIb2up6/MF5pYB/8mg==
X-Gm-Gg: AZuq6aJtgdr5XxgvOClLQRGnlFshPPZ2oJnMo2BQnERO3uqaTifwZcu4ZrgKIqYg0fi
	iFibUaBTIVpsor1bMBGqKZlzQFpww2JEX5dgB/MI+9+3ygBBQPV0cvBo5ZKI1SuMTTdZiIOyKkq
	wsOf5PPB0OphHJnQ1cpBbmFx2p8ZnjBoesM78mt2FPyAV6R6u/Aikpaypen2amC+qJab6nR/dSL
	BfjgRfoOu8iyDaVEv4OVq6RMUeH7BmrnGJt2GfhytQRt+jKqodc5iGGLQ9QwOhvbEqMpcqAxz2O
	TZLPb5/93LBj7u7memhfDR/zOIqBnbMQOcmtC8mwn7c/1Z3a45Za6eSwrXDGFNM0geb+0Q2CnxA
	mbr8PTdSCwATnZ72mkveneDNKtY5nR3TvdJXiOQEAELvuDsxkxaN0i8eaqGA37uMGVU2lQBATxM
	YZFLjCg6F5jHEy0Acf11V75xRP/g36NxlIB79HBXopKRaJpJ89QgPrQm/orAbz/qmsxejzaTk=
X-Received: by 2002:a05:7022:6184:b0:123:2d38:928d with SMTP id a92af1059eb24-1270405aa72mr3860925c88.36.1770523442099;
        Sat, 07 Feb 2026 20:04:02 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:6d43:22d7:40eb:81e6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041e61b9sm7085064c88.8.2026.02.07.20.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 20:03:59 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: jassisinghbrar@gmail.com
Cc: Douglas Anderson <dianders@chromium.org>,
	Frank.Li@nxp.com,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	andersson@kernel.org,
	arm-scmi@vger.kernel.org,
	cristian.marussi@arm.com,
	festevam@gmail.com,
	imx@lists.linux.dev,
	jay.buddhabhatti@amd.com,
	jonathanh@nvidia.com,
	kernel@pengutronix.de,
	konradybcio@kernel.org,
	krzk@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	mathieu.poirier@linaro.org,
	michal.simek@amd.com,
	nm@ti.com,
	rafael@kernel.org,
	robh@kernel.org,
	shawn.guo@linaro.org,
	sudeep.holla@kernel.org,
	tglx@kernel.org,
	thierry.reding@gmail.com
Subject: [PATCH v2 00/15] mailbox: Stop sending NULL mailbox messages
Date: Sat,  7 Feb 2026 20:01:22 -0800
Message-ID: <20260208040240.1971442-1-dianders@chromium.org>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[chromium.org,nxp.com,kernel.org,pengutronix.de,vger.kernel.org,arm.com,gmail.com,lists.linux.dev,amd.com,nvidia.com,lists.infradead.org,linaro.org,ti.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20896-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:mid,chromium.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3CF79107C8F
X-Rspamd-Action: no action

As talked about in the first patch in this series, passing NULL as the
'mssg' argument to mbox_send_message() ends up causing confusion and
quirky behavior inside the mailbox core. Despite this, there are a
number of drivers that pass NULL.

It is plausible that some of the drivers passing NULL may have been
taking advantage of the quirks of the mailbox core. Specifically, they
may have been taking advantage that calling "tx_done" wasn't truly
necessary for NULL messages (it was a noop) or that NULL messages were
passed onto the mailbox controller right away without queuing.

This series introduces a new API call: mbox_ring_doorbell(). The new
API call tries to mimic the specific quirks that were helpful in the
old behavior and it's expected to be a nearly drop-in replacement.

There are some subtle differences between the new call and the old
behavior, but it's expected that all of these differences are only for
cases where the old behavior made little sense. The description of the
first patch details these differences.

The series attempts to convert all in-tree users to stop passing NULL
for mssg. As per above, there are some slight differences in behavior.
If any of the patches are causing problems, they can safely be
reverted while debugging the problems. Eventually, all code should be
converted over to stop passing NULL mssg.

Changes in v2:
- Instead of just documenting NULL, introduce a new function

Douglas Anderson (15):
  mailbox: Deprecate NULL mbox messages; Introduce mbox_ring_doorbell()
  ACPI: PCC: Use mbox_ring_doorbell() instead of NULL message
  firmware: arm_scmi: Use mbox_ring_doorbell() instead of NULL message
  firmware: imx-dsp: Use mbox_ring_doorbell() instead of NULL message
  firmware: tegra: bpmp: Use mbox_ring_doorbell() instead of NULL
    message
  irqchip/qcom-mpm: Use mbox_ring_doorbell() instead of NULL message
  remoteproc: xlnx: Use mbox_ring_doorbell() instead of NULL message
  rpmsg: qcom_glink_rpm: Use mbox_ring_doorbell() instead of NULL
    message
  rpmsg: glink: smem: Use mbox_ring_doorbell() instead of NULL message
  rpmsg: qcom_smd: Use mbox_ring_doorbell() instead of NULL message
  soc: qcom: aoss: Use mbox_ring_doorbell() instead of NULL message
  soc: qcom: smp2p: Use mbox_ring_doorbell() instead of NULL message
  soc: qcom: smsm: Use mbox_ring_doorbell() instead of NULL message
  soc: ti: wkup_m3_ipc: Use mbox_ring_doorbell() instead of NULL message
  drivers: firmware: xilinx: Use mbox_ring_doorbell() instead of NULL
    message

 drivers/acpi/acpi_pcc.c                       |  4 +-
 .../firmware/arm_scmi/transports/mailbox.c    |  8 +-
 drivers/firmware/imx/imx-dsp.c                |  2 +-
 drivers/firmware/tegra/bpmp-tegra186.c        |  4 +-
 drivers/irqchip/irq-qcom-mpm.c                |  2 +-
 drivers/mailbox/mailbox.c                     | 82 ++++++++++++++++++-
 drivers/remoteproc/xlnx_r5_remoteproc.c       |  2 +-
 drivers/rpmsg/qcom_glink_rpm.c                |  3 +-
 drivers/rpmsg/qcom_glink_smem.c               |  3 +-
 drivers/rpmsg/qcom_smd.c                      | 13 +--
 drivers/soc/qcom/qcom_aoss.c                  |  3 +-
 drivers/soc/qcom/smp2p.c                      |  8 +-
 drivers/soc/qcom/smsm.c                       |  8 +-
 drivers/soc/ti/wkup_m3_ipc.c                  | 10 +--
 drivers/soc/xilinx/zynqmp_power.c             |  2 +-
 include/linux/mailbox_client.h                |  1 +
 include/linux/mailbox_controller.h            |  4 +-
 17 files changed, 108 insertions(+), 51 deletions(-)

-- 
2.53.0.rc2.204.g2597b5adb4-goog


