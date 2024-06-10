Return-Path: <linux-acpi+bounces-6285-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62024901C73
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Jun 2024 10:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0571C21CED
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Jun 2024 08:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E956F311;
	Mon, 10 Jun 2024 08:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SSdm1Yf7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2A26F067
	for <linux-acpi@vger.kernel.org>; Mon, 10 Jun 2024 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718006898; cv=none; b=qqCzE17dPKMU5m8SXboX+BJUG9BD7PWuOBsO6uo8DcCQuw8rIk+ZN6PQ3vU6SUUEfGbdoX7TEhr/OMVedTiNBVeqnbghohWTd1G5jbiSSvwwE3f9i7mRML758m8Mbdz43mnfgg7WIoq6HFOlyq5bE6FWhaQcXTQtgI3tjwhqvPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718006898; c=relaxed/simple;
	bh=/L5y1Dv6ivY3eszYnYmdXRYc401x9YYY2yBAmmyUG/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LyTuFz3CBiGsrT5NwYdALRUXHBFE96lWetesquNsV+JGZQVPKQykjab45FFPrW8S6EJZoV2DDiaGyeaA8f3LZGoxjeUDKXxWaRBiKDfs519PouZl2ddTNO/5NLKTdgORe4V476Mvsutf5WG9MJVD2iDEx9D7+WmOX8rviJC3yAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SSdm1Yf7; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5295e488248so4550162e87.2
        for <linux-acpi@vger.kernel.org>; Mon, 10 Jun 2024 01:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718006892; x=1718611692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/L5y1Dv6ivY3eszYnYmdXRYc401x9YYY2yBAmmyUG/k=;
        b=SSdm1Yf7Ra0G4T+e1Uib9M+gpZrMF9N8k3TFc0cVz1F5pABZzdduYWAgb/AYK6aN5U
         uGRb/9C4DKJ1MAyhzNdKqtcLtbbSe8pWQRtjbEXBTFYju2cMxL2Ljf60A9rhzibs/z9k
         58QLu/Go6rD3ZcOU2IPsm9uBcLwH6W8ua/ujy6yuJ5oy7dAijMMVBbsXY4yd4XeI8BMF
         tBO40weDDLMTfnvv7w8kEWecrxwMfi5uAXCD7QK5dcWAdVEgifdMXyQiRMcm7v1g27Rl
         Fpd3yivenYWJYij2nMGl+Ls46Hekj1+LChnFu8YHVJOJbKSpUse8j4k2fpw4j2G2Sdq2
         vB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718006892; x=1718611692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/L5y1Dv6ivY3eszYnYmdXRYc401x9YYY2yBAmmyUG/k=;
        b=lWGo+nZ0NTBzyRZeVPWpkYwHPq7qbHTH2A72/9O5EQ01mchClroI/Ocgd59cDtewBB
         nWWO2SRiNyOE7pWg3reReb73iEnEMX9Qkl/xEetuNuBYv5BuB6/25h/7P8WSCTt+p9Ab
         VC/DONXJ6lz9WdJ95pmM1LeAdqUhJtjlV3KpMpPBSnBVJMCkpXxlJpQsVea3jvUqHbBH
         XMNwGNk2MLMiXaIhTDY0IQNZYdS5CzotQedsbk3Cnscb1EwUoH4RJ4X8dSKIcGJJNlpA
         gjsD/WzL8kV5Uho9yNX1GZC96fdetsRyqFZDzLT6Dj2epNWdWtoGosi1b249bNq5vkL9
         k3Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUyVqKX+KVH/X3hKwqjBnzudB7M4pyTi2KQat4IDeMGxWPuyqAdw1obhfJOcFA8fBUzJpU6hkJgvUS0yGVB2bvYj8MPQG2/lLVUdA==
X-Gm-Message-State: AOJu0YxoTesK+EGGryUG5hMCJncjMz3vGmbVb4K8wQ1GqGMS962H+DlM
	YKpYWH/ZDCAWvf26Oy8II5f6g6Skk/UD0yVThdNFdK/0MOJIFUHTON5SrgbPhwIkrFzUdz9O4lm
	JF+EvsXPrXEfzvQzAXPL/3Q+LoxaBa2IwvJ+rZA==
X-Google-Smtp-Source: AGHT+IEoIIaopVbMhKiBzu+ZFeFG117iZrYhuaSy1PLsnicMvCE0nAaF1iUL9hhnUeVtUHqe9i20V059/u6XmSWe6yI=
X-Received: by 2002:a05:6512:234d:b0:52b:be9b:cafe with SMTP id
 2adb3069b0e04-52bbe9bcbadmr5940256e87.21.1718006892189; Mon, 10 Jun 2024
 01:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603211538.289765-1-andriy.shevchenko@linux.intel.com> <87tti9cfry.fsf@intel.com>
In-Reply-To: <87tti9cfry.fsf@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 10 Jun 2024 10:08:00 +0200
Message-ID: <CACRpkdZFPG_YLici-BmYfk9HZ36f4WavCN3JNotkk8cPgCODCg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] treewide: Align match_string() with sysfs_match_string()
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Corey Minyard <minyard@acm.org>, 
	Allen Pais <apais@linux.microsoft.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Perry Yuan <perry.yuan@amd.com>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Nuno Sa <nuno.sa@analog.com>, Guenter Roeck <linux@roeck-us.net>, 
	Randy Dunlap <rdunlap@infradead.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Lee Jones <lee@kernel.org>, 
	Samuel Holland <samuel@sholland.org>, Elad Nachman <enachman@marvell.com>, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Johannes Berg <johannes.berg@intel.com>, 
	Gregory Greenman <gregory.greenman@intel.com>, Benjamin Berg <benjamin.berg@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Robert Richter <rrichter@amd.com>, Vinod Koul <vkoul@kernel.org>, 
	Chunfeng Yun <chunfeng.yun@mediatek.com>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Nikita Kravets <teackot@gmail.com>, Jiri Slaby <jirislaby@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Stanley Chang <stanley_chang@realtek.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Abdel Alkuor <abdelalkuor@geotab.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Eric Biggers <ebiggers@google.com>, 
	Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, Daniel Bristot de Oliveira <bristot@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, 
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Mark Brown <broonie@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-ide@vger.kernel.org, openipmi-developer@lists.sourceforge.net, 
	linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, qat-linux@intel.com, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-mtd@lists.infradead.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org, 
	linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-usb@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-hardening@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, alsa-devel@alsa-project.org, 
	linux-sound@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, David Howells <dhowells@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Sergey Shtylyov <s.shtylyov@omp.ru>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Heiko Stuebner <heiko@sntech.de>, 
	Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
	Danilo Krummrich <dakr@redhat.com>, Jean Delvare <jdelvare@suse.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@intel.com>, Hu Ziji <huziji@marvell.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Potnuri Bharat Teja <bharat@chelsio.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, Kalle Valo <kvalo@kernel.org>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, JC Kuo <jckuo@nvidia.com>, 
	Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Sebastian Reichel <sre@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Helge Deller <deller@gmx.de>, Brian Foster <bfoster@redhat.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 9:46=E2=80=AFAM Jani Nikula <jani.nikula@linux.intel=
.com> wrote:

[Maybe slightly off-topic, ranty]

> Why do we think it's a good idea to increase and normalize the use of
> double-underscore function names across the kernel, like
> __match_string() in this case? It should mean "reserved for the
> implementation, not to be called directly".
>
> If it's to be used directly, it should be named accordingly, right?

It's a huge mess. "__" prefix is just so ambiguous I think it just
shouldn't be used or prolifierated, and it usually breaks Rusty Russells
API rules times over.

Consider __set_bit() from <linux/bitops.h>, used all over the place,
in contrast with set_bit() for example, what does "__" represent in
this context that makes __set_bit() different from set_bit()?

It means "non-atomic"...

How does a random contributor know this?

Yeah, you guess it. By the token of "everybody knows that".
(Grep, google, repeat for the number of contributors to the kernel.)

I was considering to send a script to Torvalds to just change all
this to set_bit_nonatomic() (etc) but was hesitating because that
makes the name unambiguous but long. I think I stayed off it
because changing stuff like that all over the place creates churn
and churn is bad.

Yours,
Linus Walleij

