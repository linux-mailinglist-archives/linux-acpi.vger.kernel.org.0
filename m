Return-Path: <linux-acpi+bounces-21553-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eE5sDs7nrmlRKAIAu9opvQ
	(envelope-from <linux-acpi+bounces-21553-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 16:31:26 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5F923BB4D
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 16:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A382305C24A
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 15:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC92B3E3D9C;
	Mon,  9 Mar 2026 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TN8xwSyF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7BC3E0C42
	for <linux-acpi@vger.kernel.org>; Mon,  9 Mar 2026 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069954; cv=none; b=Uriyu8Au80KyJm96dz6tzTgv2SntReNtma+ARGGANb6IDuoO0VFRDI4pdrOc49p01pmP4Nl/ev7oOq6kNGbFUvpWeqw7wPJjZOgQapJ65VLXdPfSGLy8ir5xGbz18RYknph/D38hIwAWhRMzxYV7P7VP20nIoa0wpeazn80nVh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069954; c=relaxed/simple;
	bh=fLdlgK54rTn34EKZI8AHzVRLbm2SJ8RTjlamikvXF3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXIOr/FSxqoArh+jhCvMF4sRs+UC4onZA5u/1HjOja9jN0PjSNSWA3nvE/rMP7rfksG1R0dmY83CMtzYdgcXV+NMEZcHZpphETmFpzLFMEvfFbtyNRpRfFPqVwjAqKBlppOaFVcbJe4OmGlZjLOX31y/usFBeTTbk6DTDzEj6lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TN8xwSyF; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a12cd0bcd8so6156912e87.3
        for <linux-acpi@vger.kernel.org>; Mon, 09 Mar 2026 08:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773069950; x=1773674750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKq8ulzy5MHQKDxfFMVcrLftpi/uwWVl0kgu6a2rhEE=;
        b=TN8xwSyFC42UHK095LDdzU2706xJgAXWECt3XaRpQMU2eLYYnugZvizxRiOsdjjpuI
         4Y/CqePpzSBYYL76rFbqtK6CJjeINW/BNG4efXzta/YegXC8EeBjbYNBp9XOCYL402s3
         J3899s+CGGacEyo8B3JlRcQ7NeiKPQ1nBN9wU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773069950; x=1773674750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xKq8ulzy5MHQKDxfFMVcrLftpi/uwWVl0kgu6a2rhEE=;
        b=prBonyc4z5L0IhhAcgZXXBQhWZ8zZm3SI2RFMT6kO+d/fQ5Zql+NKobWV20b7RlAxB
         TxOMI2u/8lMOFdJJEdcnI1aEdv3qFlsSVZSZu50Jp3zEquW2i5JQYVd92TA+2JsGixfn
         UQ6VUbhdwnVQdTuU5MJglUE6eLYHmwD1tJH8ZLWNkUii3HDHBdHuXHar93cY3EFbiRgG
         iyMYts+PGbRQ/fPVgkiQmUcJP+AClw5GjQ311uuwwIjT6OKCPn/oK29yex5KTyzU/zCG
         fXL5ssnjWyxfOlZskZA8H1oCOA1QowABvz7bFln87wk9Vd/qWGXLbDQqpxAvY/3V6CI4
         ulRw==
X-Forwarded-Encrypted: i=1; AJvYcCXVuOHO0raHnllMLKpdn6oFvvJRIVck6VNIZ6+LbqbJshJ5aPL7bOgayk6Sd5dFg9XTEDqUGB/E5haN@vger.kernel.org
X-Gm-Message-State: AOJu0YwLJW4DQ6zuFu638cJnVfMvVxkhVyVj9+aCECyK7t5inMb0GO5a
	O3WaPZgPGHN5Ht6tA0PnTsqYt53BuUdp/GBglHUzba/kM9qKUP9yivXE5jgi8HIW0DUTPPuVsN4
	9ptNApbW3
X-Gm-Gg: ATEYQzwWVTEpCooD/PtewOrPtcnGsrLvDztCFNhMa/AkdFCdBspsbt68nAIRkHdRiFy
	iixjb3zAx76M9fhCvPAAs9XQxpzix+Fjs69t0X0eisl4XkfCMfFR5x5hLoQ2QtkydZRxp718+om
	azRtTAyNrdgd3XMVqmjefn6bqaRQv0YllhybosfC/oPMAvX+zhbRlpyTjuYU5A5IwjcDb62MEzQ
	LHg5Ge3n+h21uCUXpWURcaxu60Q/udfpvneI5atZOk3e5SrGX2W8zemuMrxH1cXGgx9NPiWDVpB
	y8hICoFT2l+2tCdIP9vYmfzXK1Bs/uua1hzYXMOBFqKwvhESEqlOqBlXryBb/FNKCtILzZAOl18
	SPZdNaBpxJrxSCWr3/TR4nXJHFCza2N3Vno5Ppe6f8P0VO8zrio2D+9Yz43J4mVlYtsDWsgZX/E
	w7ea/j+kDyaC1oF4mL/TkR4o5YcScKJPgrt4QrAEHaAS1m2B5JjdTem62r77j4PtB/vw==
X-Received: by 2002:a05:6512:3e12:b0:5a1:1da2:24b with SMTP id 2adb3069b0e04-5a13cac1c73mr3837656e87.13.1773069949638;
        Mon, 09 Mar 2026 08:25:49 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d036700sm2248384e87.35.2026.03.09.08.25.49
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 08:25:49 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3870778358aso117368971fa.1
        for <linux-acpi@vger.kernel.org>; Mon, 09 Mar 2026 08:25:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXf8EGAi4sdFpAl9Ene56BrYAOnKFKFHFLK3FWV4p2osEIJlqrziHL5MTa8xtUPpWvzrMDGkkwifpsg@vger.kernel.org
X-Received: by 2002:a17:907:1c2a:b0:b96:dcc0:2e19 with SMTP id
 a640c23a62f3a-b96dcc03e2bmr431706766b.56.1773069586848; Mon, 09 Mar 2026
 08:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216181002.3475421-1-dianders@chromium.org>
In-Reply-To: <20260216181002.3475421-1-dianders@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 9 Mar 2026 08:19:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XosP+rpT7w1Dcr=Xu7K8MCnA-=hndCgvsdwRAeVXuUdA@mail.gmail.com>
X-Gm-Features: AaiRm52PitiYzwSf40xttz_JauQBZgQS8kA13tji_SRNQ2F75XcOox36FcsJy20
Message-ID: <CAD=FV=XosP+rpT7w1Dcr=Xu7K8MCnA-=hndCgvsdwRAeVXuUdA@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] mailbox: Stop sending NULL mailbox messages
To: jassisinghbrar@gmail.com
Cc: Frank.Li@nxp.com, Santosh Shilimkar <ssantosh@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, andersson@kernel.org, arm-scmi@vger.kernel.org, 
	cristian.marussi@arm.com, daniel.baluta@nxp.com, festevam@gmail.com, 
	imx@lists.linux.dev, jay.buddhabhatti@amd.com, jonathanh@nvidia.com, 
	kernel@pengutronix.de, konradybcio@kernel.org, krzk@kernel.org, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-tegra@vger.kernel.org, lucaswei@google.com, marco.crivellari@suse.com, 
	mathieu.poirier@linaro.org, michal.simek@amd.com, nm@ti.com, 
	rafael@kernel.org, robh@kernel.org, shawn.guo@linaro.org, 
	sudeep.holla@kernel.org, tglx@kernel.org, thierry.reding@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: ED5F923BB4D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21553-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,kernel.org,pengutronix.de,vger.kernel.org,arm.com,gmail.com,lists.linux.dev,amd.com,nvidia.com,lists.infradead.org,google.com,suse.com,linaro.org,ti.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[chromium.org:+];
	NEURAL_HAM(-0.00)[-0.988];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:dkim,chromium.org:email,mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Jassi,

On Mon, Feb 16, 2026 at 10:11=E2=80=AFAM Douglas Anderson <dianders@chromiu=
m.org> wrote:
>
> As talked about in the first patch in this series, passing NULL as the
> 'mssg' argument to mbox_send_message() ends up causing confusion and
> quirky behavior inside the mailbox core. Despite this, there are a
> number of drivers that pass NULL.
>
> It is plausible that some of the drivers passing NULL may have been
> taking advantage of the quirks of the mailbox core. Specifically, they
> may have been taking advantage that calling "tx_done" wasn't truly
> necessary for NULL messages (it was a noop) or that NULL messages were
> passed onto the mailbox controller right away without queuing.
>
> This series introduces a new API call: mbox_ring_doorbell(). The new
> API call tries to mimic the specific quirks that were helpful in the
> old behavior and it's expected to be a nearly drop-in replacement.
>
> There are some subtle differences between the new call and the old
> behavior, but it's expected that all of these differences are only for
> cases where the old behavior made little sense. The description of the
> first patch details these differences.
>
> The series attempts to convert all in-tree users to stop passing NULL
> for mssg. As per above, there are some slight differences in behavior.
> If any of the patches are causing problems, they can safely be
> reverted while debugging the problems. Eventually, all code should be
> converted over to stop passing NULL mssg.
>
> Changes in v3:
> - Suggest mbox_ring_doorbell in the warning message
> - Updated patch description based on Cristian's response.
>
> Changes in v2:
> - Instead of just documenting NULL, introduce a new function
>
> Douglas Anderson (15):
>   mailbox: Deprecate NULL mbox messages; Introduce mbox_ring_doorbell()
>   ACPI: PCC: Use mbox_ring_doorbell() instead of NULL message
>   firmware: arm_scmi: Use mbox_ring_doorbell() instead of NULL message
>   firmware: imx-dsp: Use mbox_ring_doorbell() instead of NULL message
>   firmware: tegra: bpmp: Use mbox_ring_doorbell() instead of NULL
>     message
>   irqchip/qcom-mpm: Use mbox_ring_doorbell() instead of NULL message
>   remoteproc: xlnx: Use mbox_ring_doorbell() instead of NULL message
>   rpmsg: qcom_glink_rpm: Use mbox_ring_doorbell() instead of NULL
>     message
>   rpmsg: glink: smem: Use mbox_ring_doorbell() instead of NULL message
>   rpmsg: qcom_smd: Use mbox_ring_doorbell() instead of NULL message
>   soc: qcom: aoss: Use mbox_ring_doorbell() instead of NULL message
>   soc: qcom: smp2p: Use mbox_ring_doorbell() instead of NULL message
>   soc: qcom: smsm: Use mbox_ring_doorbell() instead of NULL message
>   soc: ti: wkup_m3_ipc: Use mbox_ring_doorbell() instead of NULL message
>   drivers: firmware: xilinx: Use mbox_ring_doorbell() instead of NULL
>     message

Just checking to see if there is any addional changes you need from me
on this series. It looks like it's -rc3 which is maybe an ideal time
for this series to get some linux-next bake time? A good number of the
patches in this series have Acks from maintainers so they could all go
in your tree, I think. For those that don't, I guess worst case they
just don't land right now and I can re-post them later. ...or if you
think they would be OK to pickup that would be cool too.

Thanks!

-Doug

