Return-Path: <linux-acpi+bounces-6187-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5103A8FC4B3
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2024 09:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069111F22193
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2024 07:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CCC18C335;
	Wed,  5 Jun 2024 07:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwxDi6gV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CDD1922F9;
	Wed,  5 Jun 2024 07:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573085; cv=none; b=OZM3X0hgK6JzSne2NpBiI0CFOiFEVvgiGyfetupQWnsAN4nptVYcgxUYh6ncuthkz7p7nAsEA1J6CII38j7Jn2M/bB4QpqEicAPbo/ZHQkY1XzIfhDxlJ1BsiA1TcezdxPrelYMrEZUVl5C2fEO4AX6jfQ+C/hN+qznSH5ZBgrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573085; c=relaxed/simple;
	bh=4yM/wI32avSH0RS9ciqQ4wcoPwL6cs7kX9mFZ0MD9tQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=I+7QvmZnLcqrcVoLT+zCvzeN69Tv2dhaAuP9TRBEQ+grLRdpP5ZAXXLDUU5iaJ7SyLFpN0YNGAuKOpPQLxXTYbpCZTr9MDcovStb1AXV2MphDEWqLwVubE6a+lf3vOSwZdfGcWeQh3Ubmzk+QzTk1qEgaqGXfvmscu0H920OQFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwxDi6gV; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-1f62217f806so56500065ad.2;
        Wed, 05 Jun 2024 00:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717573083; x=1718177883; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e8BWSpIlzHJyNkmNvRW327/r98gdCbnh5C95lF/K86k=;
        b=GwxDi6gVfCh0PpcV/C5B5uoSIDC/xn+I1RzG9k5KooiteJ8nkq7J2nPPxYesF1v8FB
         pbekavR0j3TsoYP2CXan6y3k/eMZaPko6sukEAEeTCaaaKO1CC8WN4nnthXNsPPJ0XR/
         jz01+lfDcq1ICKRpkCQYUn6Ox3s6Fw/AGgao6oXaUg7WvgQGiEA+Yg/cGxScZeumruiw
         2wF7+LCRk299M0kOGfUhAm46OXkjlCaQ4En3X19gvmAkkW9dycr3T6otJhjP8CTZGWYG
         D5JQgMMFkGeWjFRhSe3MFpGaXan0+QAPbdZsZLJjyA7MNtg5Vx35oHFuRGIb3378UH/M
         tJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717573083; x=1718177883;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8BWSpIlzHJyNkmNvRW327/r98gdCbnh5C95lF/K86k=;
        b=AfLVMg8YlgHk+zprzy7JoEU2cJSIfZbtgfZwfJ157BBxLKh6YxgGraRZKPdrl/2bqD
         pQEVSOYH2hggDnOa22IoyiLqdJctFDYgp0GYtHdxy6ofhcS7lUw1DYsIEpY2TkORHij3
         A2PvCQ2gMlKzpFMeO197LaP7SuUuAtQwFoUQ7keUFBqoLzxEhIf0yweu/xT7aK8/3N/u
         191/gOJ7ecBqN4fUUTVJmDC5yMUn62Cv6W6Y4v357/w1zGKbDxR7fL8ObqfoaRc7GzzT
         Wv0lza1/QwQyBRdAX96ErDsA+5xmVg7nFCMzop7/vMDJ7gLjPAg2T9TgmjI67rjOFdEP
         1vTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzN1GAgax2+lC9Lgdmq9TAepKBinUl0eG+ImeZh4DU6xPVkgta4GbUogb2kc/oij7vaf5Hqo6Kc9ageeVdLymHivenuWFOq4kps1Cp6DIAC+AkCpxKPVsea2sCb3xrC71QgAK7WCbqLDKPQnZXeaGlOOw/fFzGXmR6RQxoPV0asQHjOY26/8jYEFuHgXEAtdas1iwHN1B8j+94KGVZa9o=
X-Gm-Message-State: AOJu0YzOo513JfxB9T4KBS02ff2h+PP6wApdL61JStTNfvP3okO3GZea
	yCanM5YbwLW/Q5AIjgIPcaQ2HaCs1mxSEnYYHwg2g2wL7ucUP5Zo
X-Google-Smtp-Source: AGHT+IHh5cxecQo/wp3TkXPB4T7v8hzDY+DRBHVH9fdZp5fHLInM0xzv5DCE8mytLXwDepY1szGczg==
X-Received: by 2002:a17:902:d504:b0:1f6:80e2:e423 with SMTP id d9443c01a7336-1f6a5a849fcmr21687855ad.68.1717573083206;
        Wed, 05 Jun 2024 00:38:03 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f64cff714csm77680805ad.215.2024.06.05.00.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 00:38:02 -0700 (PDT)
From: Frank Wang <frawang.cn@gmail.com>
To: bjorn.andersson@linaro.org,
	heiko@sntech.de,
	heikki.krogerus@linux.intel.com
Cc: gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	devicetree@vger.kernel.org,
	djrscally@gmail.com,
	hdegoede@redhat.com,
	krzysztof.kozlowski+dt@linaro.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	rafael@kernel.org,
	robh+dt@kernel.org,
	sakari.ailus@linux.intel.com,
	william.wu@rock-chips.com,
	yubing.zhang@rock-chips.com,
	frank.wang@rock-chips.com
Subject: Re: [PATCH v5 5/7] usb: typec: mux: Allow multiple mux_devs per mux
Date: Wed,  5 Jun 2024 15:37:55 +0800
Message-Id: <20240605073755.17452-1-frawang.cn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220422222351.1297276-6-bjorn.andersson@linaro.org>
References: <20220422222351.1297276-6-bjorn.andersson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

Hi Bjorn,

> In the Qualcomm platforms the USB/DP PHY handles muxing and orientation
> switching of the SuperSpeed lines, but the SBU lines needs to be
> connected and switched by external (to the SoC) hardware.
>
> It's therefor necessary to be able to have the TypeC controller operate
> multiple TypeC muxes and switches. Use the newly introduced indirection
> object to handle this, to avoid having to taint the TypeC controllers
> with knowledge about the downstream hardware configuration.
>
> The max number of devs per indirection is set to 3, which account for
> being able to mux/switch the USB HS, SS and SBU lines, as per defined
> defined in the usb-c-connector binding. This number could be grown if
> need arrises at a later point in time.
>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v4:
> - None
>

With this commit, TCPC device shall match *two* endpoint ports both for switch
device and mux device if they have the same parent node like the following
existed DT. It causes the callback function is invoked twice both for switch and
mux in tcpm_mux_set() process.

// arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
&usbdp_phy0 {
        mode-switch;
        orientation-switch;
        [...]
        port {
                #address-cells = <1>;
                #size-cells = <0>;

                usbdp_phy0_orientation_switch: endpoint@0 {
                        reg = <0>;
                        remote-endpoint = <&usbc0_orien_sw>;
                };

                usbdp_phy0_dp_altmode_mux: endpoint@1 {
                        reg = <1>;
                        remote-endpoint = <&dp_altmode_mux>;
                };
        };
};

BR.
Frank

