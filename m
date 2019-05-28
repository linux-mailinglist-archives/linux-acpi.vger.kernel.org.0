Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDD42BD19
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2019 04:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfE1CDq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 May 2019 22:03:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46631 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbfE1CDq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 May 2019 22:03:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id y11so5593724pfm.13
        for <linux-acpi@vger.kernel.org>; Mon, 27 May 2019 19:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=babayev.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JaRPKvxw8+L+l1OScOFu7hcSbVbLQEUBHgcFnYYHmu4=;
        b=UoloAsRruBW1XQDpfAyHrpJiDnUusRnJGYAd3/CPmhR9+d00govfBjxS7ZRMtQs0DT
         pkp3tpflZlxImlkyMcfYcKdblDGWPHVZJLZOpaioebFMoPJsWLyVyOMalaIxVh1s3GV6
         IxFv2mFwubmVUqaI2Ubqa3MFjUyaEgK/Ehidg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=JaRPKvxw8+L+l1OScOFu7hcSbVbLQEUBHgcFnYYHmu4=;
        b=TwnQQf71FqgRGxRwhsUbCt9MSxmPjHUtBC7v2cZtW1ZMj7PJFja38SrA6pTV88NLE2
         eK73J4r027XJSFTizuSrFL1jxh+3xxlgGFMkvQkmkqHE9TdQJOvDFCdZaE5uAb4t3JWy
         +TrJuRZYWC2ehfXM5NzSvRormka67Q66HC5IKt5ZxM8kAFRN7a1ZTLEGDSyefMD0StJJ
         MyGzdTbkqgIl0QKOxx4YhCC3tBENFiDbq0kIfUXj5tVxb2SCbYwLRjqS9jAOpmVtFYdh
         3fvJxF4MNJcBL4oa6T7G8T7T0gJW0vw4b/rpEJLDFEZRY3TBwMcWHBLMa1Kkci+FeAgG
         1NyA==
X-Gm-Message-State: APjAAAXAv6+xNo2+CyEzXDPX+SNGsPUhlQJap1WyHKjRd3bIb4eKdwbj
        EnyGczWhuJV+8IYQ076Au49c5Q==
X-Google-Smtp-Source: APXvYqw2SNP/oW+Z1HqXmWCh/MRHPfCU1W0Ako0J9SiTpph/+j3M6XiUeGDrvUXSkpmF5PVfGG+p2w==
X-Received: by 2002:a17:90a:2042:: with SMTP id n60mr2230768pjc.8.1559009025213;
        Mon, 27 May 2019 19:03:45 -0700 (PDT)
Received: from localhost ([128.107.241.177])
        by smtp.gmail.com with ESMTPSA id u6sm6899535pgm.22.2019.05.27.19.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 19:03:44 -0700 (PDT)
References: <20190505193435.3248-1-ruslan@babayev.com> <20190525005302.27164-1-ruslan@babayev.com> <20190527184743.GA8808@kunai>
User-agent: mu4e 1.0; emacs 26.1
From:   Ruslan Babayev <ruslan@babayev.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Ruslan Babayev <ruslan@babayev.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        xe-linux-external@cisco.com, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] i2c: acpi: export i2c_acpi_find_adapter_by_handle
In-reply-to: <20190527184743.GA8808@kunai>
Date:   Mon, 27 May 2019 19:03:44 -0700
Message-ID: <874l5f9vy7.fsf@babayev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Wolfram Sang writes:

> On Fri, May 24, 2019 at 05:53:01PM -0700, Ruslan Babayev wrote:
>> This allows drivers to lookup i2c adapters on ACPI based systems similar=
 to
>> of_get_i2c_adapter_by_node() with DT based systems.
>>=20
>> Signed-off-by: Ruslan Babayev <ruslan@babayev.com>
>> Cc: xe-linux-external@cisco.com
>
> Please have a look how your patches look in my inbox:
>
> May 05 Ruslan Babayev  ( 129) [PATCH] net: phy: sfp: enable i2c-bus detec=
tion on ACPI based systems
> May 05 Ruslan Babayev  (  65) =E2=94=9C=E2=94=80>[PATCH 1/2] i2c: acpi: e=
xport i2c_acpi_find_adapter_by_handle
> May 24 Ruslan Babayev  (  65) =E2=94=94=E2=94=80>[PATCH net-next v2 1/2] =
i2c: acpi: export i2c_acpi_find_adapter_by_handle
> May 05 Ruslan Babayev  (  65) [PATCH net-next 1/2] i2c: acpi: export i2c_=
acpi_find_adapter_by_handle
> May 06 Ruslan Babayev  (   3) =E2=94=9C=E2=94=80>[PATCH RFC v2 net-next] =
Enable SFP support on ACPI
> May 06 Ruslan Babayev  (  65) =E2=94=9C=E2=94=80>[PATCH RFC v2 net-next 1=
/2] i2c: acpi: export i2c_acpi_find_adapter_by_handle
> May 06 Ruslan Babayev  ( 120) =E2=94=94=E2=94=80>[PATCH RFC v2 net-next 2=
/2] net: phy: sfp: enable i2c-bus detection on ACPI based systems
> May 07 Ruslan Babayev  ( 154)   =E2=94=94=E2=94=80&=E2=94=80>
> May 07 Ruslan Babayev  (  10)     =E2=94=94=E2=94=80>
> May 22 Ruslan Babayev  (  29)       =E2=94=94=E2=94=80>
> May 05 Ruslan Babayev  (  93) [PATCH net-next 2/2] net: phy: sfp: enable =
i2c-bus detection on ACPI based systems
> May 06 Ruslan Babayev  (  25) =E2=94=9C=E2=94=80&=E2=94=80>
> May 06 Ruslan Babayev  (  99) =E2=94=94=E2=94=80&=E2=94=80>
>
> This is highly confusing, and super hard to find out which patches belong
> together. v2 2/2 seems even missing. Please resend this as a new series w=
ithout
> any in-reply-to, and a fresh cover-letter, so I know which one to apply t=
o my
> tree.
>
> Thanks,
>
>    Wolfram

Will do, sorry about that.
