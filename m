Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36A0ED75C0
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2019 14:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbfJOMEw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Oct 2019 08:04:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfJOMEw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 15 Oct 2019 08:04:52 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8771921D7E;
        Tue, 15 Oct 2019 12:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571141091;
        bh=Af6D4mZ/pAOp+0vxSjhgtzL8DdJ7w/JcKlLEB64bg40=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vbUfGVlHWGmDXNlB+xK0XO0bQJ0Zil7F2AT3RwASF6CrCmzbfpxKjVH7hkv7zqWrt
         TsaJKjJAc3h+oKPBPdJooYP9SyRBdX3GlamtjLvEOndPEi+Xyy0OzKzi4dy84sgT97
         rU25VTT1baoFL9eMGBo4xJ7uzH1oULgaa+icytkc=
Received: by mail-qk1-f170.google.com with SMTP id 201so18853182qkd.13;
        Tue, 15 Oct 2019 05:04:51 -0700 (PDT)
X-Gm-Message-State: APjAAAU4hWzb+KumagBOW0IJizP5g3e1erjXYhola8pRlbs+BSkrIqod
        fr1/UDBXc2/UFp90hZgMxpqSCM0VL2MZXTEWoQ==
X-Google-Smtp-Source: APXvYqz9VdxmwoAHoBVcG9POQFt15AQvDXliJoTvoymJwUK2yJYHzGHFF68s8mYbG89XcQYTMs3JdOvwQioW54ma03E=
X-Received: by 2002:a05:620a:12f1:: with SMTP id f17mr3721782qkl.152.1571141090652;
 Tue, 15 Oct 2019 05:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191011191521.179614-1-saravanak@google.com> <20191011191521.179614-2-saravanak@google.com>
In-Reply-To: <20191011191521.179614-2-saravanak@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 15 Oct 2019 07:04:39 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKCLnmLDCC3UKqpKDTysiM=w78wTCwbrsmQ39oQUg=+ww@mail.gmail.com>
Message-ID: <CAL_JsqKCLnmLDCC3UKqpKDTysiM=w78wTCwbrsmQ39oQUg=+ww@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] of: property: Minor code formatting/style clean ups
To:     Saravana Kannan <saravanak@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Frank Rowand <frowand.list@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 11, 2019 at 2:15 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Better variable and function names. Remove "," after the sentinel in an
> array initialization list.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/property.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
