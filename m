Return-Path: <linux-acpi+bounces-6566-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27141912308
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2024 13:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60EE284996
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2024 11:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5097717279B;
	Fri, 21 Jun 2024 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JWlY3w3n"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BC9495E5
	for <linux-acpi@vger.kernel.org>; Fri, 21 Jun 2024 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718968186; cv=none; b=UhtsVgFXXKeEDefeYIgiLq45aY9mGvDGuBN1PJWyiQtsfIHCH7lb4X10QoT8thy/F487svVVFdOPOpXjiqT7AqEbvOruriuKN04B0okJSrjvOgbmdIiXH8W93VE5X0f6NDeBF6isAyTN2OzNSxrHLs2NThs4r2wdf7Ufu9gVBg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718968186; c=relaxed/simple;
	bh=UeyG9kchf0zxgEEgp8jDwoE/Hk2+bGBJeSvo9sphu+k=;
	h=From:Date:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFrxQGsPg8Zn5/lolyR/cf1koYxEkaF/rrxco3EznUE0KvFv2VHo7kWuAnlF/hVJWwUlDYZNQZN+wi9FSbsJ7xmLE926LFJe1TuUH0T1F8jdAL0nBhtb0LmeQKQgHiSNHGIXcXJjhyDs5aTyPwQaPi0bqGqYLXJTNiGQilKumaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JWlY3w3n; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-421d32fda86so21616765e9.0
        for <linux-acpi@vger.kernel.org>; Fri, 21 Jun 2024 04:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718968182; x=1719572982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHsuFVS4awsFBM2t6sm8Ys7eAj/jRRpqo2iTjlv95r0=;
        b=JWlY3w3nrlWtAd0DbMHDLXl0a8H2xFi3cYSssmhQSZAaPDC1GM7xtj6bN3JxWbwYNR
         vuHqiWQ0x+NGv+7MX3gRw18JcmNtX+w1sf+ZYjj9Tgy6Ea85eeA8jXb9/h5tm7fbHbsl
         wD1kzAFtzWqyOywKpUeuLL+7dQ50SgU1DlhNhYpL/uhFI998xTKp0lx1spb6WKuPEO2o
         K1NrDRLL+PJpX5wkJIyrM9O6IQPQNPVYKLGgH/YxdcPKCEJ8j7dr5Dl/gQdi44wRWGxB
         Q56Gqlli0vbnEuTn5HdLcQbOP/AJo6YizQJzBJJdogZ9F5QVwQNCk8g2liJ34E9murFl
         OZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718968182; x=1719572982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHsuFVS4awsFBM2t6sm8Ys7eAj/jRRpqo2iTjlv95r0=;
        b=cc/fECXg2sPc+YdpdHnprxD8vpdLajgwqGV0Y+SQEmw3EFm4GmDmpPTfvAgNTFJ8Vz
         CtDS9bIbJ2i6LgSMBmSZAxIKg61n9iGgLl2F0ibA/h9QJ20dx8sHByWAL/deaDHkjtzd
         phmSxhaLKl4wmMn3TsyFDTOtPsYKgzdXPs73PHHRiMrO0S17T1OoskjUqLvpLEn8gXso
         9XGeJr/i0NhsaC60wz/qsoK1m3PqgIKrtFdJxccenQc+toYDtybQxKNkHfEzX14BbJrh
         fM+4vlTcPRnwwJGex0HLfzUYfNzV3EGcIF2c7fVCpyfwd42KZEv8Fc/WG0CLC0+JsF9l
         7COw==
X-Forwarded-Encrypted: i=1; AJvYcCW/lVghjN903Xffq7gUZnHMtufLhTPQu20+sK8pdIlqA/VgvcP1oF2WtYTILSotDIxWIS/4NrRqlgGgr2icBc+GbwyzdT34WgEOKQ==
X-Gm-Message-State: AOJu0Yxm49I9mXrHhduo4aCG6HLoSom7zb5CX+EPJBalmGSwNpmIq91C
	/DCg6Up6/GFPTKvGZlaUevc6ef37SXgoymH1uaUuwihmhgTjjFtAME39mZjo6tk=
X-Google-Smtp-Source: AGHT+IHWqSd+4b+kL5eIms84HqApIOoZ4q4j0hTUEyemhj6WJGlU7JqnCm60md9Qk2uphszXRZUqNA==
X-Received: by 2002:a05:600c:b4d:b0:422:7899:76d2 with SMTP id 5b1f17b1804b1-4247517fd71mr76062285e9.17.1718968182584;
        Fri, 21 Jun 2024 04:09:42 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d212254sm59634675e9.45.2024.06.21.04.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 04:09:42 -0700 (PDT)
From: Petr Tesarik <petr.tesarik@suse.com>
X-Google-Original-From: Petr Tesarik <ptesarik@suse.com>
Date: Fri, 21 Jun 2024 13:09:39 +0200
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Petr Tesarik <petr.tesarik@suse.com>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: CPPC: add sysfs entry for guaranteed performance
Message-ID: <20240621130911.78e4eec1@mordecai.tesarici.cz>
In-Reply-To: <CAJZ5v0hBR1qGgSq3+sYU_7ChphHuL_R7E1-LBjXE3FdWUPkWpg@mail.gmail.com>
References: <20240606115541.2069-1-ptesarik@suse.com>
	<20240621104848.3f14d60e@mordecai.tesarici.cz>
	<CAJZ5v0hBR1qGgSq3+sYU_7ChphHuL_R7E1-LBjXE3FdWUPkWpg@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Jun 2024 12:16:06 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Fri, Jun 21, 2024 at 10:49=E2=80=AFAM Petr Tesarik <petr.tesarik@suse.=
com> wrote:
> >
> > On Thu,  6 Jun 2024 13:55:41 +0200
> > Petr Tesarik <ptesarik@suse.com> wrote:
> > =20
> > > Expose the CPPC guaranteed performance as reported by the platform th=
rough
> > > GuaranteedPerformanceRegister.
> > >
> > > The current value is already read in cppc_get_perf_caps() and stored =
in
> > > struct cppc_perf_caps (to be used by the intel_pstate driver), so onl=
y the
> > > attribute itself needs to be defined. =20
> >
> > Are there any objections to exposing this CPPC register through sysfs?
> > I mean, if everybody is OK with it, the patch could be acked and queued
> > for 6.11, right? =20
>=20
> It actually has been queued already, sorry for the missing notice.
>=20
> It's been in linux-next for some time even.

Oh, OK, I could have checked myself. ;-)

Thanks!
Petr T

