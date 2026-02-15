Return-Path: <linux-acpi+bounces-20992-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id w2J/HNYgkWn0fgEAu9opvQ
	(envelope-from <linux-acpi+bounces-20992-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Feb 2026 02:26:46 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F06713DDDC
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Feb 2026 02:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF013300461D
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Feb 2026 01:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB151A3172;
	Sun, 15 Feb 2026 01:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoCJMzSL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B36833993
	for <linux-acpi@vger.kernel.org>; Sun, 15 Feb 2026 01:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771118798; cv=pass; b=iw+qARDMYIjEdyc25BDCmGLZRNQ+ZJWXvojJ/ox5mM+UHGfYw/1MwaGPAOAamOqO03SoHLruzbXfFlq7KIK2XczcdVaNoAod4217y6C+KG8PaiPTCx8vNtD/wRzkqxuD8xvrYFClMIe8NSbTvdE7mI1sUnw23/uwQCbGYyjYw3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771118798; c=relaxed/simple;
	bh=IzdGBGFCpilT6AeHHAkF6quAsV2MXMS40zGkPPdg0HE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4n8jwuBvHfhbvLn9KkoeEogBKSnU8kMIP5TtaT0ZQeCnlEj8wQCOIjxXKFJeMinlOtwgP2/5c9Vi1qf7kRat/DdmYCMK2+dltacTTToS1DRZ4gSXZlVpZHhis3RCle4Z8vEXEaKJ01nheHP4Zyn3sfpgyWQwVWtI7e17BgFZmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoCJMzSL; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d18d02af68so1482087a34.2
        for <linux-acpi@vger.kernel.org>; Sat, 14 Feb 2026 17:26:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771118796; cv=none;
        d=google.com; s=arc-20240605;
        b=Bw/YQ6jg5J2Pbpqg7nIFJO+nN5yUkjy/5CjcpXbXzM+ruUukGinM1kZza7q+ZRjCtL
         TrgPB5mqH6q/QjirtfjDt/fH6Qr9IYuZhqc3UmY/73X1gSS43fjlqgvUdeoPGhYAB2b3
         T2WSwdxTXuphxXKlQOldHwVNA5aX26/VIicE1HpBpBkyH0QFgsGtUGxb3wgf6w/PEro1
         pxICUsGPT3LCRLBX/rbe1DfTzAoRxrVmj6aYur8EQ/YJFIXVlKxeIrOkogh4llixBKbs
         fwoIK1b1AgvtcUFbiSHYgtHU4aRDypmJkQnrR6P4faMd79kBlPT84Bn9YP1EMCWIoK+2
         p5aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oc6M0vaTZcmARSII2t0Y1J43OpPVtanNHASTzTLjxa4=;
        fh=fQzerckGONtsEOeroGANEBC5Mw6PY+9hQT7KHyhNaWM=;
        b=HiR2B+aZtO+2cwyHcMIv8tguyE9omzj4YYYf+bK+VF+FP64KMe13O2WMQlAvmVX24Q
         Br61qLcclGlweVmunqeG6QgPm5kO2VGM+klVPdxjeG94Q0dgN9yRxp9n1uHc/1PEXCPk
         p09JzI87cbrTb5Jj/TaToClNhqjoGs89IUVKMJZgnvjazes/+l4zPlrtiKzU2Ow16ESM
         /KcmVHKIleVCbAo1wGYgMeZHHmSvhGoa7+HXy3tSGGc6j0wRmDL8gdMU1p6ptHPKAm8+
         U62Ox+2r5NDzV9JnEs9he8vfzz54y1c5gC3Edt/YsEWFiRFnfZ5eCFSyGcrYQ0fkSpLA
         a2EA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771118796; x=1771723596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oc6M0vaTZcmARSII2t0Y1J43OpPVtanNHASTzTLjxa4=;
        b=hoCJMzSL2yvps+LZZxezUiGv2qIqJYPlgfVrAI9PVJX5adV5TumNu9JBjSwe/VzYtB
         dUm+r6Vqnp77akqRwbQ3beiIZ0lkCV0iDxKh50951RYJEDQw3RIurZw/Pu8v7MHvCfQu
         SvIioHJDP9J3lHfSNTeOBlAIiMse2+mYYUEwZVWEkSBbEmo/LKDMmTCcYhms1Ok8q9E/
         MqPPVTMa5eVS8do5VkN50a4J0eQ9TZAMWG6ZQVErUAydqN1zf6nmpcLWsdV3gxq7bFCO
         8doiphwgSJScOlLZkH7s7bWlFONWjFbKx/92/Paeg0i4HoO19kBUQrhzPnI6g5fVG5b+
         ynrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771118796; x=1771723596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oc6M0vaTZcmARSII2t0Y1J43OpPVtanNHASTzTLjxa4=;
        b=CyXiFC4gNIFXcsk6Ve4GrnDWjdWeEcYtDvCGoxRWbGWLQywGH8DdDBuFYHO9NSX/Hz
         AmL9BzET4QCHdCDa95noPG4++F/WXxVy46qoSnXUb4Ay5M3YOxRrJ80GVu78aeDte1LN
         0YPZi/CH3iUYnTn3UDOFNsssOobRR+FfOtotHpKnM+Dl9OSy7HpqMQBp3Kj37DSfGId+
         21xWTxvilu/LqYAe6hMxjplNL3e6dWc5Uy+NJNQwAFNbLhqyte6irrRuRUmpy2rL9+Dp
         quvb0Q2zzq821eim+2Zv9PHaLvqYR/3+9S984xXwWU0JBE7izYnGWN7NfqqXGWlp9ZiO
         R4Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXPhd5R69/cqrA/27tIfNHHHLwKEx4hclEikGQqW1IwC+If5DprM1NLN256PgHjQWM8tHPt1Tu9CRvT@vger.kernel.org
X-Gm-Message-State: AOJu0YwW/zg0NfWAfTvp1Am8U7UzhPWF+1MaiLhQXSpivam58WK3D3o5
	GFZClngMl6TQyWTFb5mgQSQuUDVhFcYbHvh1do/sWy2SoGrp61FQrQRjb/PG0ilUrDNhgDo0KDs
	xpOC9pE76k5vFwe9X75c0g7oaNaboHc0=
X-Gm-Gg: AZuq6aJmIUvuCer3WrWrpm5uVyKX95js+DnXZuRPZ9beSacR04t3KOh5so6yHfxBFXh
	Cp8S4S0ewEatOGRIXuNkfuWKNxwIxa5SVHQoXgh6Vff6UUckG9hlb08Q/Me0M4rMzuF0g+i6M8/
	OkT3e0z10r7KHTCz14PhZuurXvgQDTugac6QwvYLAy3ITORGqnrskT8U8CVzrUwDb9vWSRqPgkN
	HqIAF9rNpZtH6gGQeZ+Lf96+44eHUr3Kj+fRh2zh4rWGtHgtd/adwgShHtyEVab6majKFrRbC+u
	MzUNOtlYbH78h1oV9Mkh3q9t47XfkpPVprZxuEKHjg==
X-Received: by 2002:a05:6830:90d:b0:7d1:9160:7b98 with SMTP id
 46e09a7af769-7d4c302911dmr3548600a34.15.1771118796565; Sat, 14 Feb 2026
 17:26:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201130334.3107-1-sef1548@gmail.com> <CAJZ5v0jtroqWSwjF3KQsmVLPYEE4a59-cxg5ZV1BAGmJtf-Q_Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0jtroqWSwjF3KQsmVLPYEE4a59-cxg5ZV1BAGmJtf-Q_Q@mail.gmail.com>
From: Nick Huang <sef1548@gmail.com>
Date: Sun, 15 Feb 2026 09:26:25 +0800
X-Gm-Features: AaiRm53qbm9Rwn1Tz4PKVW8wtkl0gZZcYDHeT8RMibrNYsmuPOhzM3hobI7ScGM
Message-ID: <CABZAGRH7SAd2r-n4q4u=7Dt-KJnAtUTLqmWM-H8GAejq=zgttA@mail.gmail.com>
Subject: Re: [PATCH 0/2] nsrepair2: Improve sorting performance and add tests
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	paladin@ntub.edu.tw, kusogame68@gmail.com, ceyanglab@gmail.com, 
	n1136402@ntub.edu.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20992-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,vger.kernel.org,lists.linux.dev,ntub.edu.tw,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sef1548@gmail.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F06713DDDC
X-Rspamd-Action: no action

Rafael J. Wysocki <rafael@kernel.org> =E6=96=BC 2026=E5=B9=B42=E6=9C=8813=
=E6=97=A5=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=889:40=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Sun, Feb 1, 2026 at 2:03=E2=80=AFPM Nick Huang <sef1548@gmail.com> wro=
te:
> >
> >    This patch series improves the ACPI nsrepair2 sorting implementation
> >    and adds comprehensive KUnit tests.
> >
> >    Patch 1 replaces the O(n=C2=B2) bubble sort algorithm in acpi_ns_sor=
t_list()
> >    with the kernel's sort_r() function, which uses heapsort to achieve
> >    O(n log n) time complexity. This improves performance when sorting
> >    large ACPI package lists (e.g., _PSS, _TSS) while reducing code
> >    complexity by leveraging the existing kernel sort API.
> >
> >    Patch 2 adds KUnit tests to verify the repair functions in nsrepair2=
.c,
> >    covering:
> >      - ACPI operand object creation (integer, string, buffer, package)
> >      - Namespace node creation and NAMESEG comparison
> >      - Package structures for _PSS, _CST, _ALR, _PRT methods
> >      - _HID string format verification
> >      - _FDE buffer expansion
> >      - Sorting logic with ascending/descending order
> >
> >
> >
> > Nick Huang (2):
> >   ACPI: nsrepair2: Replace O(n=C2=B2) bubble sort with O(n log n) sort_=
r()
> >   ACPI: acpica: Add KUnit tests for nsrepair2 repair functions
> >
> >  drivers/acpi/acpica/nsrepair2.c      |  87 ++-
> >  drivers/acpi/acpica/nsrepair2_test.c | 854 +++++++++++++++++++++++++++
> >  2 files changed, 916 insertions(+), 25 deletions(-)
> >  create mode 100644 drivers/acpi/acpica/nsrepair2_test.c
> >
> > --
>
> The ACPICA code in the kernel comes from the upstream ACPICA project
> (hosted on GitHub) as described in
> Documentation/driver-api/acpi/linuxized-acpica.rst.
>
> Changes to that code need to be made upstream from where they are
> picked up automatically after every upstream ACPICA release (or you
> can speed that up if need be by sending a Linux patch based on an
> upstream ACPICA commit).
>
> As for the test part, I'm not sure how useful it would be given the above=
.
>
> Thanks!

Hi Rafael J. Wysocki

Thank you for the reply. I will submit the changes via a Pull Request
to the upstream ACPICA GitHub repository as suggested.
--=20
Regards,
Nick Huang

