Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8E7DE607
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2019 10:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfJUIOQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Oct 2019 04:14:16 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46166 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfJUIOQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Oct 2019 04:14:16 -0400
Received: by mail-oi1-f195.google.com with SMTP id k25so10252403oiw.13;
        Mon, 21 Oct 2019 01:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yJkx95UvleOcFFmvQVjJHb82ALHFn9Uyq35PUcIaw0Y=;
        b=eJ3LnOZen44WZ/tPE9evshDM6Cc9klSqUWva3Z17bIsXpXmqw3lo41sMzynjtom1SU
         oPIPnvgENdBj6O0yK1A8dAGjo1xDm5mX9WxvhL2kGfzpHK/tnWL1WUeh5snfF4nOTka5
         w44R+U7gtPcp9Sq5yV+F0ptaNFPpsBZ61CAHI6hR1Ga1JBqkCGAYYtp9IiPl/r3sw6G3
         iPvTAIs3WcHqumYWhjKVOS7VeKwnsIk0HII6y2OHlqY3qoZHoBADDJWj75ErT0HL5QCO
         s3RMVv/9eL9MtY5zcPDOuR+4YQrsw2o8I24JikbNWdG7IIv2lom69I4wCgWmYWHTXvd5
         6YLA==
X-Gm-Message-State: APjAAAUOZ+Hiaqy4yr/K9C8oNQn/RqklkAyFAO4p2911guNxGM68jiKZ
        t6kiTlcnrpN6hs3KDoIz4enmgeEOrnIRO8cuhCg=
X-Google-Smtp-Source: APXvYqy7s2Z6Q62WqM2aVgLMAG9NJ5QBLTyvrrtZtDgW+H6a/y3PWHqqAtwOWxN5wsb6+PZXiYWc+MWNjHm4txISCwU=
X-Received: by 2002:aca:d405:: with SMTP id l5mr17085627oig.115.1571645655327;
 Mon, 21 Oct 2019 01:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <2215840.qs0dBhReda@kreacher>
 <CACO55ttC-o9bKU7nHNcfjm2YnffiupQ7UHUt7BYL3fu+yEyTbw@mail.gmail.com>
 <5228680.jBuKzensJx@kreacher> <CAJ=jquZLU2=yxayGCs=XGghxdMMre6qAWRY0Q4VErjBGqeWdjQ@mail.gmail.com>
In-Reply-To: <CAJ=jquZLU2=yxayGCs=XGghxdMMre6qAWRY0Q4VErjBGqeWdjQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Oct 2019 10:14:03 +0200
Message-ID: <CAJZ5v0hogSM3OgfJ0GFn7+BYwxR05Hb5ZMLo=NiB2wmpu=qeug@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
 enable dGPU direct output"
To:     Alex Hung <alex.hung@canonical.com>,
        Karol Herbst <kherbst@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dave Airlie <airlied@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 21, 2019 at 4:14 AM Alex Hung <alex.hung@canonical.com> wrote:
>
> We have done some tests on three of Intel + nVidia configuration
> systems with OEM _OSI strings removed - while some bugs are still
> observed, ex. one out of three has suspend/resume issues, no system
> crashes were observed - the biggest issue that worries us.
>
> The positive results give us confident to ack the removal of the OEM
> _OSI strings. While our tests were not able to cover all possible I+N
> systems, we are sure we can fix issues along the way. If there aren't
> systems that cannot be fixed without these OEM _OSI strings, these
> strings should probably enable with DMI quirks (possible future
> patches) so they won't affect others.
>
> Acked-by: Alex Hung <alex.hung@canonical.com>

OK, thanks!

I can queue this up or if it's better to route it through the DRM
tree, please do that (and let me know).
