Return-Path: <linux-acpi+bounces-1627-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 573BB7F18B9
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 17:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF156B21062
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 16:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431641E51F
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C65B92;
	Mon, 20 Nov 2023 08:32:50 -0800 (PST)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6cba45eeaf6so280354b3a.1;
        Mon, 20 Nov 2023 08:32:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700497970; x=1701102770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzvBTPYKPNLAAYJofhHBHs2zDNnqaax2JRpt9QsB7iM=;
        b=bJX2IgX1np0Q8nTF8Ot46C5leG3f+Y84L9hcCkxSS+JN619L7hiILk7gNYl53OX7ma
         sx4buvE7NgutxXTecCSMNA8Y4lPchuIV5J8dhnEsPr8llkIooXZYSxZWeE3XiMdCeMDX
         wde4VtWzz1+ZWftBBJOTuW30h+l25A58i0WIBZAxlIV9Sewmks/HKDZ0TQPgFnoJYRgI
         MoZTtzzKgYKzVXok/AQsLgTp7Nkd+acgrka3rFGSGRin5vNTKC0zjnRuLJ789s+UDU4Q
         9+xT/dG0Ra8h5pYXNJEqL7cg0Tyr5yJmLOx6lLT34MmHYKpCzoGqyxP6latvQTn0IqQE
         E0xw==
X-Gm-Message-State: AOJu0YxLyjRz9uiXbaNhT/osgwG0FCb0Rqisp4cIv1ixzDiUnLTtxY1z
	hNJjEX1+xf2lOTw9PB+YXLcTKID+Y8D+lfBptBk=
X-Google-Smtp-Source: AGHT+IG2GolmAdfAAuerHd0wALYMQdXf2/E3bw0YDO4MyZrjW1wcH0BbupD91hhw+nZdxBAYZ+YEzNE4jRh1rw7GIz0=
X-Received: by 2002:aa7:93b0:0:b0:6cb:8347:c8b1 with SMTP id
 x16-20020aa793b0000000b006cb8347c8b1mr5083391pff.1.1700497969892; Mon, 20 Nov
 2023 08:32:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231112203627.34059-1-hdegoede@redhat.com>
In-Reply-To: <20231112203627.34059-1-hdegoede@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Nov 2023 17:32:37 +0100
Message-ID: <CAJZ5v0g6AHiGCB4vNLAXvH4TJRxMYpnD8LyNNnX0qEaTqr9o+Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] ACPI: video: Use acpi_device_fix_up_power_children()
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, "Owen T . Heisler" <writer@owenh.net>, 
	Kai-Heng Feng <kai.heng.feng@canonical.com>, linux-acpi@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Sun, Nov 12, 2023 at 9:36=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi Rafael,
>
> This series fixes a regression reported in 6.6:
>
> https://lore.kernel.org/regressions/9f36fb06-64c4-4264-aaeb-4e1289e764c4@=
owenh.net/
> https://gitlab.freedesktop.org/drm/nouveau/-/issues/273
> https://bugzilla.kernel.org/show_bug.cgi?id=3D218124
>
> The reporter has confirmed that this series fixes things and
> Kai-Heng has confirmed that backlight control still works on
> the HP ZBook Fury 16 G10 for which the original
> acpi_device_fix_up_power_extended() call this replaces was added.
>
> Assuming you agree with this series, can you get it on its way
> to Linus so that it can be backported to 6.6 please ?

Both patches applied as 6.7-rc material, thanks!

