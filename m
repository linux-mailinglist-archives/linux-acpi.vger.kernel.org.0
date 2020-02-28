Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0F5817345B
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2020 10:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgB1Jnf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Feb 2020 04:43:35 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38145 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgB1Jne (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Feb 2020 04:43:34 -0500
Received: by mail-qk1-f196.google.com with SMTP id z19so2354520qkj.5
        for <linux-acpi@vger.kernel.org>; Fri, 28 Feb 2020 01:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZQpTZWkGzDGWJobzwuAfOw+XS/boYthReZIyRMS7WA=;
        b=zGlBgJoIRe/RfSDE9HfZaopWq8WV2piNpuuScoZMuTQcTFm7Rj7MXadxMl1J52m2pp
         lRBVSUEo27UOymkMXOCNeUsK5ZFmi582iShoBjR4B5kphtTxBnmjHade3IgHsIpzP4p0
         amvg1FgKhEHtAeDxH1CJK9rcz+KWWN5I+tPHeqLY9RFKOSb8/wp6Tm99onBqGNnJqlYk
         jaL7IvAscMrl0gBEGKBj8OLuP847Q2y9T5NGo8qMHI+UhUEt2niJ/Env7WBb1W0zHM+e
         KoNFYiBsHCpC/Rp8HOoYVFmxqagwOhcYMOhIa/SVH9YXQdtoa6raA5SMFkeknm77T5uw
         ykZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZQpTZWkGzDGWJobzwuAfOw+XS/boYthReZIyRMS7WA=;
        b=Fbg6Rhdpklt/jmMyUSwf0rWU2LQAk4iB0wioyYDtBKjcccvmriJBzPFrgk/uwoB8Go
         u5bzRDWPQ9oAtz7Ozqia8Zo1+AFXBvppUtBgRKmN6ep6QqHEkUosUYaMlFgzX80zgT/U
         EP2VSW0P80eVIz/BZxp0P9k3LdezCILmEaxYNY1H29pHt8AeQfB5WGBXEMtRjju1Wz21
         gqlVJnZ38bn3KSlncfHwdJe61x/S3eUjvI0K0Spuf6ZJxyc09qgPFYXiXjTalwptUQfZ
         3zGBD+X0/D2B3aQ/YhrzQOYahxnpjkcNmZW1llXorOFe2Soj6jIDLzbvIy8acF0HWcgw
         f7Fg==
X-Gm-Message-State: APjAAAUFV+/sqKC0kNkp4oI2cMyXae6f/u4yQWdBBq0LPKDMigtp4LAs
        JxwWkHClJ1eRFGevZFnLLK0yD3QS8DEK3idPRSyAgg==
X-Google-Smtp-Source: APXvYqxUoWSKm+NYzu9ZiSLa1bUICU9tgjR/Qm+eZi+RRxEOw9s1pWhOp2Oxj4m4aVk4D87nMkpVBsKiQDQXK5Rz3ZI=
X-Received: by 2002:a05:620a:12a5:: with SMTP id x5mr3582343qki.478.1582883013336;
 Fri, 28 Feb 2020 01:43:33 -0800 (PST)
MIME-Version: 1.0
References: <2094703.CetWLLyMuz@kreacher>
In-Reply-To: <2094703.CetWLLyMuz@kreacher>
From:   Daniel Drake <drake@endlessm.com>
Date:   Fri, 28 Feb 2020 09:43:22 +0000
Message-ID: <CAD8Lp46VbG3b5NV54vmBFQH2YLY6wRngYv0oY2tiveovPRhiVw@mail.gmail.com>
Subject: Re: [PATCH 0/6] ACPI: EC: Updates related to initialization
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 27, 2020 at 10:25 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> The purpose of this series of update of the ACPI EC driver is to make its
> initialization more straightforward.
>
> They fix a couple of issues, clean up some things, remove redundant code etc.
>
> Please refer to the changelogs of individual patches for details.
>
> For easier access, the series is available in the git branch at
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  acpi-ec-work
>
> on top of 5.6-rc3.

Jian-Hong, can you please test this on Asus UX434DA?
Check if the screen brightness hotkeys are still working after these changes.

Thanks
Daniel
