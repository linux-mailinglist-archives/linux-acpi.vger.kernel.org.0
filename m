Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 644D8132429
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2020 11:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgAGKxN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Jan 2020 05:53:13 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39266 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbgAGKxN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Jan 2020 05:53:13 -0500
Received: by mail-ot1-f67.google.com with SMTP id 77so75880307oty.6;
        Tue, 07 Jan 2020 02:53:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zQgMxIq/VfvRE3nG5UqBet/nAdYddLHDXbcSwRzGXB8=;
        b=X7HHS3MYKnwUqyuAHO1GUAqQ97zQoNwtf9JHphX17XNdLTQpWyvvPhRRYrSxF2Rxw0
         PggIhTLv1+bW5SyR4R+nBqiJcQR6zRG6BQmUYQuPmALeXkfNvuZQ3fQhXIKyRbKlKZhf
         CCQHLWX6SbQoIT/n3QmvHJdq60Kt30/392G1EhocSDb0FgcqcFPBrBH6z7rdjwPFkfCN
         4LHxRwoEqYqU4IzLjVEqpGVGjO7xZM4deO+D0Z5WQWKAHLcvbfyaquJWtMr+m0GYjuMd
         Z8ChJQzW681NnREVVmyyYrvmdeSoo3kYwIa4BU0VHuUYSatGZC7H+g3guNZutIwqYbti
         qOvg==
X-Gm-Message-State: APjAAAUaW2rzHkGa82AeKwRsl7P+1DSFqey3OavPXdWxM9KdRSZcLL2c
        sSpv7kpn5mdxANk3lnmKU1965fEsWdm627ymXX0=
X-Google-Smtp-Source: APXvYqy0cMm1oxIX74m7J9Bap5GaDWP72fzfk1QKMa8V/r3WF4XJqww8DNutMlLPLM0vZKb7GMzTU+Le3mgFzN7L7W8=
X-Received: by 2002:a05:6830:1651:: with SMTP id h17mr114686171otr.167.1578394392565;
 Tue, 07 Jan 2020 02:53:12 -0800 (PST)
MIME-Version: 1.0
References: <20191206175409.335568-1-jason@jlekstrand.net> <20200102202754.24028-1-jason@jlekstrand.net>
 <7eba4578-42e2-69da-99a3-2fc316a588b8@redhat.com>
In-Reply-To: <7eba4578-42e2-69da-99a3-2fc316a588b8@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Jan 2020 11:53:01 +0100
Message-ID: <CAJZ5v0iBbHQ=jeKpsq45eQzNMS+xxH_8kCUS-T-VLVFT-tZDzw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: button: Add a DMI quirk for Razer Blade Stealth 13
 late 2019 lid-switch
To:     Hans de Goede <hdegoede@redhat.com>,
        Jason Ekstrand <jason@jlekstrand.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 2, 2020 at 10:27 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 02-01-2020 21:27, Jason Ekstrand wrote:
> > Running evemu-record on the lid switch event shows that the lid reports
> > the first close but then never reports an open.  This causes systemd to
> > continuously re-suspend the laptop every 30s.  Resetting the _LID to
> > open fixes the issue.
> >
> > v2: Updated the comment to better describe the behavior of ACPI
> >
> > Signed-off-by: Jason Ekstrand <jason@jlekstrand.net>
>
> Thanks, looks good to me now:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Applied as 5.6 material, thanks!
