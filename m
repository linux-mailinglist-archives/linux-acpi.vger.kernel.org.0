Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 138A1136BCB
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2020 12:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgAJLQ1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Jan 2020 06:16:27 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37129 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgAJLQ0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Jan 2020 06:16:26 -0500
Received: by mail-io1-f67.google.com with SMTP id k24so1677213ioc.4
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jan 2020 03:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E0kTgke7i7no5YSGmsSsdd4ls6keOfUqGJvkD2ZqyfQ=;
        b=NnePBo6iCOPCCl8M3uUdxEi3EwgCfLxTravxBpRnXZlApT5tkOTYTwa5YdVOdf7Hqr
         InO7lLE8tbhmVGA1ABlD/sztCr/eIMOczIR1fivwLrjTlnuDqqwhfKKtW8tvpugFxWmg
         GNWAbWWujCvRjDbYEgDo7yrXAnrF7U7Hadn/or4/SYCnqQufiOsdeyAjytF9tveiYn+f
         oWbAHJ3uG61eS+jpIPo+RDY2SZBE1Gyzfup2d5vmYkV6IHtdsM+h0vWbki//QJRuoPKr
         t4U9hrqfIvz7+5UwF01sXX3QDVTz5ySaxHMVN8NN3icKAsX7aGNIo9vnQSu1nuFU4vQr
         P0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E0kTgke7i7no5YSGmsSsdd4ls6keOfUqGJvkD2ZqyfQ=;
        b=KPFGPYWEFVsYpQ54sS1SjU261gFsftv8p3Yi4G9qPwvY7Oap1JB71Kg02hI0g8XCEM
         Fuv69Y05dMbvmcHd7lbMfjvDiWFea9m9dq8f2pHJXGBhqiU8OUNUlkU10TbAdwMf6yfa
         fCAH74wMLLwDslc+ln1uxUWLrgmjncCYSZeYXTFwF+NZG9L2SjHhCodM3q2swzNWZQPi
         87R1gkaCSMvi0UqAjokqPNnWJRAIb2JZPmsQ1DvCcgfivcwHzIWEq+qWNVLbrl22pJuj
         sUckFMUktVUDXecp/MA1e3f+np0xC4hs5guvI4INxLsyHPsROGQO9tc2Y3NaFSUbVNQg
         vaVQ==
X-Gm-Message-State: APjAAAWxIb+T7XdjvSxlKTGvYdTkNqGUKIMI9EkaUl3nyIl/Got21IW/
        yW+7CBMKNZzEaZkFtsTONqYS9YFK3zp9kIAcJZr9kA==
X-Google-Smtp-Source: APXvYqwPTjV6sa9yurHRzaTSTH6oKZ7TDKuE4ojDTaVsHmqgvbewwCwQ+R1EOsG5qONsmgHQ1T36FBP4nbNDi2uHV78=
X-Received: by 2002:a5d:8952:: with SMTP id b18mr2031946iot.40.1578654985955;
 Fri, 10 Jan 2020 03:16:25 -0800 (PST)
MIME-Version: 1.0
References: <20200109154529.19484-1-sakari.ailus@linux.intel.com> <20200109154529.19484-6-sakari.ailus@linux.intel.com>
In-Reply-To: <20200109154529.19484-6-sakari.ailus@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 10 Jan 2020 12:16:14 +0100
Message-ID: <CAMRc=MfqRqtW=nMuKFcpLrBHYg7wwPboUEvYpj2sBXM8yWEM_w@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] at24: Support probing while off
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

czw., 9 sty 2020 o 16:44 Sakari Ailus <sakari.ailus@linux.intel.com> napisa=
=C5=82(a):
>
> In certain use cases (where the chip is part of a camera module, and the
> camera module is wired together with a camera privacy LED), powering on
> the device during probe is undesirable. Add support for the at24 to
> execute probe while being powered off. For this to happen, a hint in form
> of a device property is required from the firmware.
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Why am I not Cc'ed on this patch?

Bart
