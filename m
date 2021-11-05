Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F1F44654B
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Nov 2021 15:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhKEPBF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Nov 2021 11:01:05 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:43854 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhKEPBE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Nov 2021 11:01:04 -0400
Received: by mail-ot1-f54.google.com with SMTP id i16-20020a9d68d0000000b0055c630be045so2745836oto.10;
        Fri, 05 Nov 2021 07:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N29f2qG9N8qGZBGabftefpAZctoEUTP2dAZL8SLGpjU=;
        b=BJdlrN4GK5lb1oYxH/MiUmQPypn0QxOnIr6FAz73z8+YO5NEvabYgc7m0Q/XCLELHc
         FlcueSAKlB4609zLZtBb1hTAktWzw3frsPm/ua5mOSYW6s82gIq3Ti6Ip4Y6ygWe5LTy
         qYjnlHELnxXkKSFXIT0U4iKAqtjlT5aVnV8gzPY9ejp3PYgR3M9q+mQLvTUOuQadriG+
         6YtChgv0J3YSw4NkdGP7LUlsrUbQ1KbjXY1y2bhDP97pIn7lBiT/Q9YzCLQ1cBpkgHcy
         C4OCXwPze4iQ3e8t5EiCliUPy36S8HyOjTzCXvb9TZZUL16ZfY8iBajm43aVP9/jQPxu
         qjMA==
X-Gm-Message-State: AOAM532kfvgj2FxvNcgnJWw4CP4reyjwrp1NcBjSbRMnu572gag7c4BW
        cUvXTq+9UnlzBfpPEl8L6UolRop34edOQa6F9Rk=
X-Google-Smtp-Source: ABdhPJzbBsU2kX81at/Ihg+/gwg0il6C3IJjZmh66hovIKnVJ7ey9fb5vDJvLcs9yLkSzrEoh1M6QGh3i4lQhJ38mrE=
X-Received: by 2002:a05:6830:3484:: with SMTP id c4mr28386618otu.254.1636124304787;
 Fri, 05 Nov 2021 07:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211102182542.3460787-1-sudeep.holla@arm.com>
In-Reply-To: <20211102182542.3460787-1-sudeep.holla@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Nov 2021 15:58:14 +0100
Message-ID: <CAJZ5v0jL2+1rzqB2aAJ0T6w3md2dyuHWZNKOk+AbioeD-4ccDA@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI: Add support for PCC Operation Region
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Sudeep,

On Tue, Nov 2, 2021 at 7:26 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Hi,
>
> This series adds support for ACPI PCC OpRegion added in ACPI 6.3
> I understand that the ACPICA changes need to go via different route,
> but I am posting it together to give complete narative/picture for
> the review/discussion.
>
> Regards,
> Sudeep
>
> Sudeep Holla (3):
>   ACPICA: Fix wrong interpretation of PCC address
>   ACPICA: Add support for PCC Opregion special context data

The above two need to be submitted to the upstream project via GitHub
at https://github.com/acpica/acpica

The will be applicable to the Linux code base only after they have
been accepted by the upstream.

>   ACPI: PCC: Implement OperationRegion handler for the PCC Type 3 subtype

And this one will be applied when the above happens.

Thanks!
