Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4F38E0FA
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2019 00:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfHNWrs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Aug 2019 18:47:48 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41971 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbfHNWrs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Aug 2019 18:47:48 -0400
Received: by mail-lf1-f66.google.com with SMTP id 62so411970lfa.8;
        Wed, 14 Aug 2019 15:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mh51nkxw4i+pECwFXd8sLzk2KvgQQNpCm3d01V5SCLc=;
        b=CHvoGp4JQnh7/6igKiv8z9GCoTqJCrYoz+fxQiqhikcLHa4LSTrYMYcDueLpewcbV+
         XsOLYC4hlEUMy0W06WPLP2pbxcMpuNK9WPEKX/Zuqe+ZkRn/7j4TgMFU+g/V3cititf/
         R3VHGCxWAXQ1/UK7pzfhJAlwkcpcu3XDpiphxohzIWFBsDtc5qR7M6OWCkw2kpRVZth/
         527/3uI4ddV8f8XuSpfFD2G7OPazB/kgxg+NKAS6+afixY4TRIJVJW2ReiPubd8TONAD
         18iYDC3Oh3nd3IVbpy+yH1rjKpvDmbGNZgr5rsQcT/SST2W4tCDWuU+2vS7RViLWWnpV
         KAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mh51nkxw4i+pECwFXd8sLzk2KvgQQNpCm3d01V5SCLc=;
        b=B6+0/zl6J+oHnJiXRYPtadXJalFyzVz+vV+uXjMceP+pHM+oXEFqA0ukPB4R2SOpqV
         q9UgzztO6bFSawGLMCJl+MhAAkaOvJ1Asa8TkexfLvY6QxXM5Bs83SJZ/lXevsC8CWqY
         M3Bsp+eY2/s/m4VX1Ari+EbtmJUV7VSjBtYgxnivLiN/0+1uN8dejVDRd3mq6EZrqjve
         9KwBhTiGqJsjKAgkruz8WcPnArdrj5WXiXhekjJHqvQUDk3F+AwgqrQXdMdB3ugtcltd
         zvBEhyhBv1I6BRcJ/C8IxuY4ba0txeDOVF3bBu+Cvlg9WoEiREzu98sxaQjzZrTro0IY
         oAPA==
X-Gm-Message-State: APjAAAUiHBWEFZOkwxF7LCXc7fChxM7oJa1nNzFNvoPAO6+TFALR+pO+
        s6K8qjuO3ug5pAHeEW5988yugE+p5Tl++RGDc7M=
X-Google-Smtp-Source: APXvYqzycF1dfTKo9tsYRCYMSL5GBTHA1deD7nwmys7qc3LSEcP6H7UGH3733ZypXdOc1Uci79kRpKsqDioFqjLAIa4=
X-Received: by 2002:a19:f11a:: with SMTP id p26mr857848lfh.160.1565822866359;
 Wed, 14 Aug 2019 15:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <20190814213118.28473-2-kherbst@redhat.com>
In-Reply-To: <20190814213118.28473-2-kherbst@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 15 Aug 2019 08:47:35 +1000
Message-ID: <CAPM=9ty7yEUqKrcixV1tTuWCpyh6UikA3rxX8BF1E3fDb6WLQQ@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
 enable dGPU direct output"
To:     Karol Herbst <kherbst@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 15 Aug 2019 at 07:31, Karol Herbst <kherbst@redhat.com> wrote:
>
> This reverts commit 28586a51eea666d5531bcaef2f68e4abbd87242c.
>
> The original commit message didn't even make sense. AMD _does_ support it and
> it works with Nouveau as well.
>
> Also what was the issue being solved here? No references to any bugs and not
> even explaining any issue at all isn't the way we do things.
>
> And even if it means a muxed design, then the fix is to make it work inside the
> driver, not adding some hacky workaround through ACPI tricks.
>
> And what out of tree drivers do or do not support we don't care one bit anyway.
>

I think the reverts should be merged via Rafael's tree as the original
patches went in via there, and we should get them in asap.

Acked-by: Dave Airlie <airlied@redhat.com>
Dave.
