Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04EB5A10FB
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Aug 2022 14:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbiHYMsM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Aug 2022 08:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238665AbiHYMsH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Aug 2022 08:48:07 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C12AE200
        for <linux-acpi@vger.kernel.org>; Thu, 25 Aug 2022 05:48:06 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-33dba2693d0so44674567b3.12
        for <linux-acpi@vger.kernel.org>; Thu, 25 Aug 2022 05:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kJ5On2ktKziLDnctA1dZe2V1BDnH83HkqWU0FAhWOWc=;
        b=F08gqobDPOG02uds3mzNo828VbOW5X0WV5DGspM1psh9EH/iYe+ck4rV1QN+zUHNeB
         +LkZmC+ZHdFD90Y5rUnGAaWlAljJmpt9+MLRlSRorFapczYi+H/azJFjFZ4JFHNq1QlK
         1PzeMr3W3Fiz1JPyMa8HRowtA9KJAVOgsri7nBh9lmp4dZV4ugB8us2CoNB/VHzMsm1X
         3BQU/05avG7MRSdQER7pVCxPVm+zdU8Qrq9C0WaHFy1gFcl1jBgOnuKie1HgP3iqGhb0
         UvuHIC/M1u9QcVHM8i/dIg8CPNtYKIHVOKyeU0hjp/NXB5CaIBOrfFlpNP7Z55k4F3dz
         XfqA==
X-Gm-Message-State: ACgBeo04bLBz1Cjd7RZngwRdWv/7OxYjSzRlubKHOnSsKLL8Xdh26tpt
        d+1O8/qDcz+o4ZQdSzuqENaJF2Zz+eVRNOlLDUqHmiQiylw=
X-Google-Smtp-Source: AA6agR6UntRYz/P2CKGbLsGkudlJgFOkhbMiIHM+ZD17mgfXgd2uNpMsb94szUVcP6YIYOb+7K9AbczJgPFGF9psYQE=
X-Received: by 2002:a25:b749:0:b0:68f:171f:96bd with SMTP id
 e9-20020a25b749000000b0068f171f96bdmr3157805ybm.137.1661431685342; Thu, 25
 Aug 2022 05:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VczhmTTdMbj7z2DOPm+k4SWGzuLF8NyJ2FWHwhfg9HJ1Q@mail.gmail.com>
In-Reply-To: <CAHp75VczhmTTdMbj7z2DOPm+k4SWGzuLF8NyJ2FWHwhfg9HJ1Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Aug 2022 14:47:54 +0200
Message-ID: <CAJZ5v0j=90uhWRcVWKVyDhEuVNWw-W28RoKkCwxpzNd3NLC9mg@mail.gmail.com>
Subject: Re: ACPI ID list termination
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 25, 2022 at 2:38 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> I have stumbled over __acpi_match_device() implementation and noticed
> different types of termination of the struct acpi_device_id (ACPI ID
> list), i.e. '{ }' vs. '{"", 0}'.
>
> As I read the code of the above mentioned function, I see that it
> dereferences the id field without NULL check. This means we are quite
> lucky (somebody before guarantees the match) we have no crash here.

I'm not sure what you mean.

In __acpi_match_device() id is a pointer used for walking the acpi_ids
table (if not NULL).  Its initial value is the acpi_ids value and it's
incremented in every step, so it cannot be NULL.

The loop is terminated if both the first byte of the device ID field
and the cls field in the current row are both zeros, so both
termination markers in use should work.

Or am I missing anything?
