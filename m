Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC5A1CD420
	for <lists+linux-acpi@lfdr.de>; Mon, 11 May 2020 10:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgEKIi6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 May 2020 04:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbgEKIi5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 May 2020 04:38:57 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64023C061A0C
        for <linux-acpi@vger.kernel.org>; Mon, 11 May 2020 01:38:57 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d22so729933lfm.11
        for <linux-acpi@vger.kernel.org>; Mon, 11 May 2020 01:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tQf9Ej+XQ6eFBxASrrnNibLUC2sl4MF1OxA2o3tn0gg=;
        b=oNLXWh9CdNJ3MmAIEksRcdlVcZOoUa8vAFvopongSEGaM9YC5hGzdn1udVKX4Yi6jB
         0c8UzJ9xqgyg17G+B/5jYJQSk3XlQO2Z8sEt9+VoY4uz23Z4T+JsNc2T6wXbBY33Vo4V
         1L0hYNpI9lCFRlCdHd5kV07FY+2ZjCoRTdr90PulrHiohiWR56rDCkSO9GnFQt/Jd9db
         c1c90utHqKBN3oNmsYXMDAPhl/AJ9Rs2IFmevwWXcnTqIk9439eLsasQkKC89ve8OGye
         2eykkRbHv1tOf/OhJ/5AaKYwjA9r2Er1nGQ42Sq2AoY4Q31t1eV9Mju5/QaXYimo9eR8
         Mk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tQf9Ej+XQ6eFBxASrrnNibLUC2sl4MF1OxA2o3tn0gg=;
        b=eA2KyPF5Y7dqjl8eAZtrgJ/0zoRC+yw5S3ASLEerWMX9f6tr7vxzaHvVtsNP9rLTVE
         OrnpXMT886D/EyK+VGBK5Gph2AVrkbu0vqoORS0VAvOFrY0OkRdSaU3FPVUa0iqoub8X
         GTHUUKXfAlxi9zdhB0rFHDJd+oLmp4uQ0YmkMFtelMmrCDONOVbmEqT0wQ4/Pid4LFGx
         0TJjGsK6eESK2IXgKZWq+vQ2tiippks6ocMh8ql1fjG+XckoEFtTIqpSR76bovcYL2z9
         pIrzhY12uBie73hnR5jEQTU9+uzQXFut8eSWdxm+8H/OlwuoavJAsKBwUl8Xgbha2AyU
         xlag==
X-Gm-Message-State: AOAM532EfnaRvyG4hNU6iqf3nCoEisCQihb6OhPRgLTtj/ofnmYTRatz
        odUTHfpv+ufi6SqX/FHP26K3pH7BT2fFACRw73TrGeMQ9zeNWA==
X-Google-Smtp-Source: ABdhPJztGtxY9fdASqrgyw3H8AcuVh+IwBWVCW91s+dZTwdZ2SdapFSsNUlwnKGpGyZUMJ6/UvkiggS8I55CPiDrxyo=
X-Received: by 2002:ac2:4257:: with SMTP id m23mr10080447lfl.141.1589186335706;
 Mon, 11 May 2020 01:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAMpQs4JoyZcHQLahh4w8OaowQ1y3pkTCTYvDn+dkVNOQ4zDpHQ@mail.gmail.com>
 <20200511081818.GA9532@bogus>
In-Reply-To: <20200511081818.GA9532@bogus>
From:   Aaron Chou <zhoubb.aaron@gmail.com>
Date:   Mon, 11 May 2020 16:38:44 +0800
Message-ID: <CAMpQs4+QdRCTQtY7vh8Zu1gXj+7YW-SE06vc4bb+ZqMAU8uT0g@mail.gmail.com>
Subject: Re: [ARM64 ACPI] different CPU L3 cache size reported by /sys/device/
 and dmidecode
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

hi Sudeep=EF=BC=9A

Thanks for your email.

Ok, I'll check it out.

--
Regards,
Aaron.

On Mon, May 11, 2020 at 4:18 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, May 11, 2020 at 03:30:51PM +0800, Aaron Chou wrote:
> > In the system, I can get the L3 cache size from two or more ways.
> >
>
> Which platform is this ? More details would help.
>
> > Firstly, I can get it from the kernel interface, such as the `lscpu` co=
mmand.
> > Also, I can cat the file `/sys/devices/system/cpu/cpu3/cache/index3/siz=
e`.
> >
>
> IIRC, lscpu parse the above mentioned sysfs files and the above result
> match the expectation.
>
> > The way above can give me the L3 cache size is 32768K.
> >
>
> OK
>
> > Now if I use the `dmidecode -t cache` command, I get the L3 cache size
> > is 24576K.
> >
>
> Ah, that's bad.
>
> > And the real size of the L3 cache is 24576K.
> >
>
> OK
>
> > Why is it? who can explain it to me?
> >
>
> ACPI reads these cache information from PPTT. The firmware which populate=
s
> the ACPI PPTT must read it from DMI entries and keep them in sync. On
> this system, looks like the firmware tried to be more imaginative and
> populated PPTT with wrong values. Get that firmware fixed please!
>
> --
> Regards,
> Sudeep
