Return-Path: <linux-acpi+bounces-20997-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLQUCs9dk2kr4AEAu9opvQ
	(envelope-from <linux-acpi+bounces-20997-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Feb 2026 19:11:27 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B7660146E27
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Feb 2026 19:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 218D03009885
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Feb 2026 18:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552D12D5C74;
	Mon, 16 Feb 2026 18:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hb9r7TO9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E56298987
	for <linux-acpi@vger.kernel.org>; Mon, 16 Feb 2026 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771265483; cv=none; b=BoIDOrguafFRlutBsxjeMRQiSU+xnslpYu4tUXukE3jzJd+1KaK8PGGr+4PlpD0Yxw4+PvH45cgtul1CAHwXmATZjzt9VVA/LWcRFPR1MnqPvclociOFdxFK9Ogza1YapBhWRT2LbPJ+JSH8wKPvFU2RqXrahrWt4VrLEkk2wqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771265483; c=relaxed/simple;
	bh=cSCEF3PytEUhtrqx1ZL9yZAsXNXSd/VJdHuArUNHrik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iItUKWd8P+7wN9sCtzGXHpj6RIJ14sKcM9Rvf+pDU5xqPkjHvfUU1UC7kJkaT6187H3eQA520JGfurfCLIEysxfk7myzD+R2SzMltAq2m9yWyugPJ/dUQNPAwliKxX7YMIMWuS9h/AQo0tvu+3ACOVxvTUNwJ2+RXvjlUhfPaZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hb9r7TO9; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-124afd03fd1so5024753c88.0
        for <linux-acpi@vger.kernel.org>; Mon, 16 Feb 2026 10:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1771265481; x=1771870281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7qPeoOZLMpDPHLvXRZ2UOWF72e8RnmNaQnfGaf4d8jU=;
        b=hb9r7TO94koSoC4Z2JHCT70nWqtWkl9i4vVEr/uEjeyLhmmT+tNRlyKSZLmYrvZHhu
         eDPKCqGVFhc3jrSCQkVj53fKUGEhSYivMP1qcHoBLVFhFAcxDLprPObeURgLzXlZKCNN
         cBABQhOU9KyeBJuBjHIShwIvLUb/R3zbNlsuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771265481; x=1771870281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qPeoOZLMpDPHLvXRZ2UOWF72e8RnmNaQnfGaf4d8jU=;
        b=TzLuMBDN2e8mFgg/3n6NYqW0DYijXFnKL3eH7VW228uq+4D6PoiMd/hWeX5DhBflOL
         OOLvwtznWP41KHd7RSw7uVis5L1IX0t2x5xhYatPQtqvY6reGdqJsmmSt3EvO2Ot7Wl0
         tit5Bab8yXNM4nIedyBeg3qzB6m94IIWez1VTUq1zwhMbnc9/4wUG/zLWTq65Dku+MR1
         eDgHCKSdrq5el0kESpjqcZ2Gs2hKQd2NpTKJ3nB/PUeOjd+LSTo9g1UMF4yXVrvPv1Xy
         iCh1/jbQ1P0KDqPPOWhW0+JUjCPFRiX5DAv4pQ5/0P2haUAnELGt51OHAXimHHdmMXBs
         6P2w==
X-Forwarded-Encrypted: i=1; AJvYcCVN8pXA8AHhX/mMeYqrNy2lqV2rh6WD04Kd4KGf1B+EkERUX1uIm8nZeTaZQgQzIV/V5iSO+Cpta7T0@vger.kernel.org
X-Gm-Message-State: AOJu0YyywLIAkVFy1zqbdACdht8nM9jmfIJNO/zpUojoiQJTRynv4Vjb
	VVCko6XN0XisF7TnupsGiY6pNeC7MsdRnmoyiuc8k3sSjcba3UKEWuElcj+AvIVbkg==
X-Gm-Gg: AZuq6aLtcGBWxHNLnMnx/PG/e6Vgww4q7hfzqoIukpr8EHkk2VA7YuAZT75ePQ/w5FF
	Wmzg8u1/lhjL3f2ERxmG7WP3/dkEb06jzZSj9qxQse8sz+SPgBLt38AjdrP5mh/8MSkKd5yAcwc
	1U9ZTMR0EHkzZoqxOhn7GAjH2m69YGzy9kkA7BYZj47p6V7MWKLPQsnLX+pm0WhOz/NXbaGNGUn
	IW5xIYywBgqh+FBVMsG5617IViObsMfJ+K/ix+9rQOFjp1Af56vGB3giSoz8EpW/yx5E10aVTb8
	FT/6S3ldCuo7ErvcE1hEW6Dv67RQkWYNMhQ2SY8lDf8LYzV2pnVGjS80XPnvvuPOOXUkohT3fW+
	3iZk4LmkDJYqUnrFFMlS9bTSymU8BJqeEPbQdfA7Ai/XUdYt97tnUAji1iZA3oySkXyiMgKUcg1
	6Gxkw4NIP5hvtCYUjrvAoQ5oj3/3lUJwvG46RYfQEeHZ5Hs/Sw0MKP9d3AshZOjm3wSH1TfA8lI
	8Fd+rCMhjM=
X-Received: by 2002:a05:7022:aa1:b0:119:e56b:91f6 with SMTP id a92af1059eb24-12741bd1202mr3136852c88.39.1771265481071;
        Mon, 16 Feb 2026 10:11:21 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:2953:dae1:1e39:73b3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742c64282sm13724326c88.5.2026.02.16.10.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 10:11:20 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: jassisinghbrar@gmail.com
Cc: Douglas Anderson <dianders@chromium.org>,
	Frank.Li@nxp.com,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	andersson@kernel.org,
	arm-scmi@vger.kernel.org,
	cristian.marussi@arm.com,
	daniel.baluta@nxp.com,
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
	lucaswei@google.com,
	marco.crivellari@suse.com,
	mathieu.poirier@linaro.org,
	michal.simek@amd.com,
	nm@ti.com,
	rafael@kernel.org,
	robh@kernel.org,
	shawn.guo@linaro.org,
	sudeep.holla@kernel.org,
	tglx@kernel.org,
	thierry.reding@gmail.com
Subject: [PATCH v3 00/15] mailbox: Stop sending NULL mailbox messages
Date: Mon, 16 Feb 2026 10:09:37 -0800
Message-ID: <20260216181002.3475421-1-dianders@chromium.org>
X-Mailer: git-send-email 2.53.0.273.g2a3d683680-goog
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
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[chromium.org,nxp.com,kernel.org,pengutronix.de,vger.kernel.org,arm.com,gmail.com,lists.linux.dev,amd.com,nvidia.com,lists.infradead.org,google.com,suse.com,linaro.org,ti.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20997-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:mid,chromium.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7660146E27
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

Changes in v3:
- Suggest mbox_ring_doorbell in the warning message
- Updated patch description based on Cristian's response.

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
2.53.0.273.g2a3d683680-goog


