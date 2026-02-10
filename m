Return-Path: <linux-acpi+bounces-20914-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AFiADV+imnVLAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20914-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 01:39:17 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F91115B10
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 01:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E175301B736
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 00:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F91624468B;
	Tue, 10 Feb 2026 00:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCSuMGfE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4AC23EA8A
	for <linux-acpi@vger.kernel.org>; Tue, 10 Feb 2026 00:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770683952; cv=pass; b=IWA0qlZ9GCa3ucSvQ00KlbsLeK57wyrxT32iwYLreOVzad6YIYMwkIwb+BAhtACgqOdaYoYl+H4MKj/5ed8v9Ep8PmSVDDqGTwxepOnwB2sFPYyS0SDP3FGOao1DUr/6ohruCThUFtYmPYSxyGv6nRs1fvCCQY1mkkNYKKEJyD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770683952; c=relaxed/simple;
	bh=CRHDCY+aNL8cCuJ5x1LKl4BcDxts38ZAFNhckqdTfRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fg8SOYv9Q1TjOTUynb/3FYBagk+IzG8IrcJh4PeZamNg2FMnhYKjJvB0sO2Ia/+ErDT3I0DcOYJ/VEXA7zNxjSVqqu8w8xwNwBPZKqKk1bvjxumLElsJJuHPpzNit+ABipRP6VGZkA9KXIcSZkMgbBiOAkMii1RVKMcbZJbsk9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCSuMGfE; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-66307e10d1dso2685104eaf.0
        for <linux-acpi@vger.kernel.org>; Mon, 09 Feb 2026 16:39:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770683949; cv=none;
        d=google.com; s=arc-20240605;
        b=Uh1KHvzAuxcRry+x5D7HggcNzLt3gXqwHImkhpU9uX/MH1dohJbINBuB6eb0VxWfd5
         Rsug3d7Yk7lyORJoo9qSIeuP04qGsLyNWBxYUadjkcd+jR0+83Hr0RxgL3437XF+I1Xf
         bc5n524ogci+e8BVv5WKby5CTuRPebtQX2vi5Dwz3N3BnlbAldWUhqX8nWb50iwl3lFL
         +ICCVivfeh2xPCYvpGVUqFG0weNg8zDPNqXqB2L30NBNZOsiwaYsKw/mLjSCNSvhg8xW
         YCqpSx6GP4HC34vaRgdfubYnzsRniznZEZKdmB+ZF/DJOnE0YB8OYcdpeXy/rQAXE7/B
         QprQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bf5IdcegF6twrrNNR7clze4xkdFwkIRE6sG++xaVg4U=;
        fh=kxXvPB6rwbUb/2NDTxy6jt/ukSWR9sjLklPFZLX8zEI=;
        b=kOalDiSfLwzknO8X6/wdiw1SuwLhGSe4TlD4+1sfrrui8FAOd3K/hN+s9fhNj8ZreO
         C2EgGzk9neCc2JDM/6czSQjC44jnkFWkKpxCO6J9h+y9HF2ANLiGHmOdAPx1e7ol1COr
         /MpX37mfPtrQhMrAKUfhGWpguFBKIvLB+SkF1nZSVjYuOf67VS/Q+6m9bZp8MPQ3I2XK
         wQe9l3tPVzRZy5seDkEAley10Cqd8ePOcotl5Ykq2UK8oCNn3NvJvUSHQcwx9txfezqs
         LMjEAJJzd/OXTUXaMJ5kzsa0XeIFLILejKY6e9hs/r8IgZaW4ckfvS2/gqOvj57GmH9y
         OEmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770683949; x=1771288749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bf5IdcegF6twrrNNR7clze4xkdFwkIRE6sG++xaVg4U=;
        b=GCSuMGfEPfzMl3he42tzkuKrehHOEwSPbWg9z90dF81Afyi3sPX6nHguyl9DXmTk4e
         6I4gIyihsEb7ZViL/AxrsB3qEzoyeA18VCG/n5Dy7EsyjJHpAxbKkbv5kouxorw9CtSY
         ErTcKZAIcy3Ck62Eg3V5O21E360Cg5+rXaqKmHKe3Ecv1aNdGvtcCfyNZzVJEEddoNDv
         JRtyUaMb9DMW2gKJjKDCu2T3OnxM4xcAEhRlVGVsVu+/IUJ3+AUuriZmgpVGoIg8stGp
         PfG5iXK6qZQFyuDRY7Qx0LItXki1cH4fE3AjOoiegYwEYQywG2RTCdmaOzOAFkzmXgzb
         Zlew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770683949; x=1771288749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bf5IdcegF6twrrNNR7clze4xkdFwkIRE6sG++xaVg4U=;
        b=VRcIy3JTw6LgVwNfJJzR55tgwipWC9zPUMtMFdxywT5+maTaWAPjej2iq8Z8e2ff3E
         U1IZkTk1AqYgEFmZoq1gzqtGosLhFzAGyDBXIFJyoJyuTtTVvIu478DDAXrsRt31AIWA
         obd/Ro8K0YTCiIl69FQmaApmlxc8ZUqgze1YMf2RoDclSNfi2dZRlEw1xFPLiVPZuovn
         SJYOeQsnTMDt2QY24aXAQDS6ksx5fap+BQRuLR9+9SiPR+wsvY4zCYrg5CU6ttBhkCTz
         ERJbH5DDjYxaZuqbuCSPPxV0kWpOdRoBvFTVnvloVprCVX1CtZ2IFpPVMVwdNFla4ieE
         fnCA==
X-Forwarded-Encrypted: i=1; AJvYcCXyKEYlAeCMMinXuiZgvKSjD5LEKMUylqk4YvdmZKN3gE32gg5YRNgEGRIiFk7b5pGcrWlImm+fSc33@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7DkvQekw4wGHR9v8vNehzmkpv0SF6gQTViH+CnSOkPnUW6Gav
	aX6wNKRvTTagFQlT2rPwQCXJzzLcs7Fsoj4F4+rzIEjmgsQtMbUmBlfvKqwsJdGDpa+aW8kIS3e
	x5iuaCwN3+c68JoVwOhksNxkzsMd5c8Q=
X-Gm-Gg: AZuq6aKeCQRIHNaf/TU4rBld0OWaN+/fgvkAOdq3V/FwzIcZ3vOuMBYN8I+m+dfridu
	xonv2TwhQJ0AvwQyUigSdRdt0HVGf3LtCDo0bq3Xxy2R5zhJOHwzHFt2QETriQKdcYRPHjwh68J
	3YshkDncziqQA/loxoaGngB+ZWGitODtuZsRRbjuQWSPNfPGDwvE0Ue+5ctNFBhBJY0+frSkmju
	ChX/ymocR2ZcosDiocFJHh3JILuDh6BKeeA9yh+sfh9R5w0CF5YTFj72Q6SvvJR5XilvzQxHQxm
	qVuVMyHp
X-Received: by 2002:a4a:e908:0:b0:65b:257b:a898 with SMTP id
 006d021491bc7-66d32fdac10mr3465078eaf.29.1770683949518; Mon, 09 Feb 2026
 16:39:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208040240.1971442-1-dianders@chromium.org> <20260207200128.v2.1.I600d04c0553f5c5ba39c2f92201da313aedfe746@changeid>
In-Reply-To: <20260207200128.v2.1.I600d04c0553f5c5ba39c2f92201da313aedfe746@changeid>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Mon, 9 Feb 2026 18:38:58 -0600
X-Gm-Features: AZwV_QhZe5s2jbJJnfFS4JALRsv_5-7Jio6ijB129QGrcufx887IYcSq_3ToyAU
Message-ID: <CABb+yY2GbPcuPiVsE_-HCS8MbpBqvjgjDkoVLNSBDZq1bnfpEw@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] mailbox: Deprecate NULL mbox messages; Introduce mbox_ring_doorbell()
To: Douglas Anderson <dianders@chromium.org>
Cc: Frank.Li@nxp.com, andersson@kernel.org, arm-scmi@vger.kernel.org, 
	cristian.marussi@arm.com, festevam@gmail.com, imx@lists.linux.dev, 
	jay.buddhabhatti@amd.com, jonathanh@nvidia.com, kernel@pengutronix.de, 
	konradybcio@kernel.org, krzk@kernel.org, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-tegra@vger.kernel.org, 
	mathieu.poirier@linaro.org, michal.simek@amd.com, nm@ti.com, 
	rafael@kernel.org, robh@kernel.org, s.hauer@pengutronix.de, 
	shawn.guo@linaro.org, ssantosh@kernel.org, sudeep.holla@kernel.org, 
	tglx@kernel.org, thierry.reding@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20914-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jassisinghbrar@gmail.com,linux-acpi@vger.kernel.org];
	FREEMAIL_CC(0.00)[nxp.com,kernel.org,vger.kernel.org,arm.com,gmail.com,lists.linux.dev,amd.com,nvidia.com,pengutronix.de,lists.infradead.org,linaro.org,ti.com];
	TAGGED_RCPT(0.00)[linux-acpi];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,chromium.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60F91115B10
X-Rspamd-Action: no action

Hi Douglas,

On Sat, Feb 7, 2026 at 10:04=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
> @@ -249,6 +255,28 @@ int mbox_send_message(struct mbox_chan *chan, void *=
mssg)
>         if (!chan || !chan->cl)
>                 return -EINVAL;
>
> +       /*
> +        * The mailbox core gets confused when mbox_send_message() is cal=
led
> +        * with NULL messages since the code directly stores messages in
> +        * `active_req` and assumes that a NULL `active_req` means no req=
uest
> +        * is active. This causes the core to call the mailbox controller=
 a
> +        * second time even if the previous message hasn't finished and a=
lso
> +        * means the client's tx_done() callback will never be called. Ho=
wever,
> +        * clients historically passed NULL anyway. Deprecate passing NUL=
L
> +        * here by adding a warning.
> +        *
> +        * Clients who don't have a message should switch to using
> +        * mbox_ring_doorbell(), which explicitly documents the immediate
> +        * sending of doorbells, the lack of txdone, and what happens if =
you
> +        * mix doorbells and normal messages.
> +        *
> +        * TODO: when it's certain that all clients have transitioned, co=
nsider
> +        * changing this to return -EINVAL.
> +        */
> +       if (!mssg)
> +               dev_warn_once(chan->mbox->dev,
> +                             "NULL mailbox messages are deprecated\n");
>
Nit: maybe  "NULL mailbox messages are deprecated, use
mbox_ring_doorbell instead" ?

Thanks,
Jassi

