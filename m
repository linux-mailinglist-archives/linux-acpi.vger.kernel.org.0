Return-Path: <linux-acpi+bounces-591-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B107C5721
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Oct 2023 16:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B832817B1
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Oct 2023 14:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8997120306
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Oct 2023 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdfGOIn6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D601F195
	for <linux-acpi@vger.kernel.org>; Wed, 11 Oct 2023 13:08:49 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A82AA9;
	Wed, 11 Oct 2023 06:08:47 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-504a7f9204eso8363703e87.3;
        Wed, 11 Oct 2023 06:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697029726; x=1697634526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYM9UN1cQM24eN/cx1yRvLKv4WydXJJTwKdXLA9EWM8=;
        b=fdfGOIn6tWJIfLGDqKmVroC1PK/c37r2YuQcFBAanciQg7QFn8r+eDD7Quc6euRCGs
         d9tT5RV33GZHiXceKzTN+4wYqMQ/PL/YwwHA80w8xSODcngfp2G2JCyyjv9RW3BLyAWk
         VbxsiixST+GEHoTpjLYh3tEQb2pJsxHv+zPhhELKY2V7W+8Z1NixX/yQRiu6kgndT9Uc
         Aado8LHwgb0N8v2SxYpFOXMTFxQQHFOnmK1zmYHdOAZVauRYoUuLrqvVHRovcc0zi8oN
         AqgOzpEeqKtJpFhkuhxtHVsnXaLtsm7VhwXx+6b8pFUgTrrIeDorcicvAZ4oW+138OWI
         B0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697029726; x=1697634526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYM9UN1cQM24eN/cx1yRvLKv4WydXJJTwKdXLA9EWM8=;
        b=tzuB/xeWiIKVq18iXuAoC0VfNKqFyfkrfcDESImXO1UeqVnGL3GJk88xY0hai5aoEz
         q3Iqo3/TpmVtr2+mA8Q9VIIz2F1071po5MHQpLlExuRGGPrKe/CihXut/0y73QFWgxtp
         5Rf1i10YPECUipPe0hbIBE4LKMITv+Y2mc+uio0tQrIJVJm7CB82yAz1dcZfgLrxhGmB
         z1lZPnJGEG6e2y+Nxz6M1VVtf2sTU9xHBuS5ZY2sH97Yb4QOa025Uo7rlqR8NJHqvrMI
         I6l+NbmoIBzfTpcs6vfutHqCX8tZfYjE2xvTLSlrXKEGQ2YW7BsEiMcjV7v2NnqJJ4JY
         XgoA==
X-Gm-Message-State: AOJu0YzIZrIZxvD/0yMhw/fC3LFT7dxcYGRfgLcinZEfJ8B0frevtYw3
	3mKUIWP/ZBrfnutsZ28mj6NPrBPWmJP/VbRe/jQ=
X-Google-Smtp-Source: AGHT+IEjN10vumMrnkaVLm49rRcsyi0oHpP0pF8gEAjsR7W/99v8G6qx2BYXKqogcr2nJ1Z3MXtFLamAEVvS47wud0A=
X-Received: by 2002:ac2:4431:0:b0:503:258d:643c with SMTP id
 w17-20020ac24431000000b00503258d643cmr16419640lfl.21.1697029725500; Wed, 11
 Oct 2023 06:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E1qkoRr-0088Q8-Da@rmk-PC.armlinux.org.uk> <ZSV6i4pnjQqvWuKp@shell.armlinux.org.uk>
 <87o7h5l5xr.ffs@tglx>
In-Reply-To: <87o7h5l5xr.ffs@tglx>
From: =?UTF-8?B?VG9tw6HFoSBHbG96YXI=?= <tglozar@gmail.com>
Date: Wed, 11 Oct 2023 15:08:34 +0200
Message-ID: <CAHtyXDdr_R_Moypb3ieFs54RRGu+zqHS46WrjEvWCFtT0KZRaQ@mail.gmail.com>
Subject: Re: [PATCH] cpu-hotplug: provide prototypes for arch CPU registration
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-acpi@vger.kernel.org, James Morse <james.morse@arm.com>, loongarch@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com, 
	justin.he@arm.com, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-ia64@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello Thomas,

st 11. 10. 2023 v 14:06 odes=C3=ADlatel Thomas Gleixner <tglx@linutronix.de=
> napsal:
>
> Sorry for the wrong information about ia64. The removal did not happen
> because someone stepped up as a possible maintainer.
>

Does that mean that the removal patch will be reverted soon in
asm-generic and linux-next? Both have no ia64 as of now, and there are
already a few patches without ia64 part (e,g,
https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit=
/?id=3D2fd0ebad27bcd4c8fc61c61a98d4283c47054bcf).
Without the revert, patches affecting ia64 will conflict.

I am the person who volunteered to maintain the architecture. If the
removal was indeed cancelled, me and Frank Scheiner can start testing
and reviewing patches affecting ia64.

Thanks,

Tomas

