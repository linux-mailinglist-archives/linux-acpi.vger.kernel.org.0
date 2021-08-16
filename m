Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C603EDB08
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Aug 2021 18:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhHPQhh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Aug 2021 12:37:37 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:41769 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhHPQhh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Aug 2021 12:37:37 -0400
Received: by mail-ot1-f49.google.com with SMTP id c2-20020a0568303482b029048bcf4c6bd9so21620896otu.8;
        Mon, 16 Aug 2021 09:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ix8+ma2hRSRB6TsuMzzL4P2LquTNuBRuyajxTyn+CcA=;
        b=nyRA2qe3j2vFJ0zPJhJlCpgWN++1sPHooxMV3MpoMCjg6BNehiAh3nSPRghWfc74BS
         kipAz0f17pOO10VgpHg3wQWeV/pE5obfxddmwGBL+ickeIURCfhj8W3JZw2aKGvlOl/1
         KonrzTCIBwIQkysquj/mr5L8IBbdeXdDoTOt4GhdiqoQthitzNzsrO31VOOcJCxdCCna
         FbQLQwVE2sXlTD38wK/0Dy/iX29Z0pw+fDbsyJpjdQ6xdr3jxt0/BxFK6V/9WI88ExN4
         rHfhDLd1KDqBBvQhV4Ihem86yZqoawAxA4tFjoaLQv4ZyQSsWbQzDxF7m0BpDo0Y+jDY
         Or4g==
X-Gm-Message-State: AOAM530uGSe7n8ZdgsPfY7hkKSn5ioAX5Tr5zSqyg5yHCZBjvf8TFCww
        EdYyoS72leaVazVmXVRUIwGE+JJoGaFIbeKITuY=
X-Google-Smtp-Source: ABdhPJwcOBw4MyS0eIJRRyOjVFYlCKSjqzd8A5VYhbU0NwlutM88zROW/V04QCbxlUJxJ9nsbxauLkvvgP23GoFwyeo=
X-Received: by 2002:a9d:7396:: with SMTP id j22mr8155544otk.206.1629131825161;
 Mon, 16 Aug 2021 09:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210806220906.326758-1-djrscally@gmail.com>
In-Reply-To: <20210806220906.326758-1-djrscally@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Aug 2021 18:36:54 +0200
Message-ID: <CAJZ5v0ikQQbUNdqskxcbbuDDp2zevG8JP5hGzqBPu1rdcgFWiA@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 0/2] Check for endpoints in fwnode->secondary
 more sensibly
To:     Daniel Scally <djrscally@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Aug 7, 2021 at 12:09 AM Daniel Scally <djrscally@gmail.com> wrote:
>
> Hello all
>
> A while ago I patched fwnode_graph_get_endpoint_by_id() to check for endpoints
> against fwnode->secondary if none was found against the primary. It's actually
> better to do this in fwnode_graph_get_next_endpoint() instead, since that
> function is called by fwnode_graph_get_endpoint_by_id() and also directly called
> in a bunch of other places (primarily sensor drivers checking that they have
> endpoints connected during probe). This small series just adds the equivalent
> functionality to fwnode_graph_get_next_endpoint() and reverts the earlier
> commit.
>
> Resending with +CC linux-acpi

Both patches applied as 5.15 material, thanks!
