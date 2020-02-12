Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7B1715A06C
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2020 06:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgBLFRP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Feb 2020 00:17:15 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:37440 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgBLFRO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Feb 2020 00:17:14 -0500
Received: by mail-oi1-f181.google.com with SMTP id q84so881445oic.4
        for <linux-acpi@vger.kernel.org>; Tue, 11 Feb 2020 21:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lambdal-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=swj2e1unZxLTr+eU0S7w12ZleMVKRnLyFuIP1piSS8I=;
        b=Eu8Jwz8tweAfLxp6xoPZfgE9THQgs4DJNn7wnaYMtugxlu505ZfPJ3pz5VMg5qLKaC
         9VeRCjshOY23jCKCcAd+eVEMBFdCVVCfJEmdbxn9ikrdk+tRHGj5JEv8mukh9AOy3kCp
         zDNwamsReN9LG+oaaVEwr/h2rM8GqQC0KfKTU2iO0k/DOcZRgYFTGMDiHZ9hQI5r5GsI
         Rj+n8dblIV8XAZBFZw5mgLsBtek/krVVXSjP7izhE9NxwxxIS1YK8MZScVNtmxEjjySn
         n799xyRJ5Xo+iOY1CFhbyAqnoZGSyBeB3/wmy80wwFvp+53uv+7+YvNrF1mRL0Uvi7it
         u2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=swj2e1unZxLTr+eU0S7w12ZleMVKRnLyFuIP1piSS8I=;
        b=FMLfe6RL9GAvp8VOtCsZS9yTQuuo0y/LfBeZqQnR03MgSxeN3C+M0MaI0Rx53grFrh
         OccVVz5X/hsBzMFimThdTB4rmiqc/iwsNrJnkY+r40vuSNK08cEsdks+/5i6KI+kf+XF
         WlEGBh6fwfUuvil/YhTfJZgJnl/xN9j9NQB/e/jGb2e6DGd2WZRLStoXnI9E4zX/PCDa
         rOXrXe8Wdf2whuDZ3Suk6beKj0SV3VeHwk+1iAXmPewQsSVvOpT/87fPSI0Jbo8ROXAk
         CkeBZCNBzhoJo32zf0i7ujPku7+kmXJ53sfOy2kjy/1zFQ4Pf7LS1HY1KL250RC8RmtC
         R9gg==
X-Gm-Message-State: APjAAAXS5XuRGIDVqYmDDbbG/KJdHzF59gRDjFRZhKsGm8ASFVAO7tOw
        vUP+ii+nQ3Aetv6Hq/DI4+fK6xoqk60=
X-Google-Smtp-Source: APXvYqxi/NgsDLYK2/SMRqF+1b27DULShmfgn7/RR1WgMr8iPTvE+CAhzeOFNJhfEIIyYQGOxJfGQg==
X-Received: by 2002:aca:530e:: with SMTP id h14mr5027806oib.105.1581484633975;
        Tue, 11 Feb 2020 21:17:13 -0800 (PST)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com. [209.85.210.44])
        by smtp.gmail.com with ESMTPSA id f37sm2005124otb.33.2020.02.11.21.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 21:17:13 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id 59so678889otp.12;
        Tue, 11 Feb 2020 21:17:13 -0800 (PST)
X-Received: by 2002:a9d:7a56:: with SMTP id z22mr7525771otm.201.1581484633007;
 Tue, 11 Feb 2020 21:17:13 -0800 (PST)
MIME-Version: 1.0
From:   Steven Clarkson <sc@lambdal.com>
Date:   Tue, 11 Feb 2020 21:17:02 -0800
X-Gmail-Original-Message-ID: <CAHKq8taawUbZWubQ8qzy05+qUKuCAYGy7kEZ-PkgPeFhode5gg@mail.gmail.com>
Message-ID: <CAHKq8taawUbZWubQ8qzy05+qUKuCAYGy7kEZ-PkgPeFhode5gg@mail.gmail.com>
Subject: Request to cherry pick 2b73ea379624 into 5.4.x and 5.5.x
To:     stable@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Greg,

Commit 2b73ea379624 ("x86/boot: Handle malformed SRAT tables during
early ACPI parsing") fixes a boot hang on some ASUS motherboards with
an older BIOS. Could you pull this into 5.4.x and 5.5.x? Should cherry
pick cleanly into both.

Thanks

Steve
