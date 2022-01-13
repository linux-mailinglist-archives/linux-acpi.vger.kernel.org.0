Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C040F48D6C3
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jan 2022 12:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbiAMLio (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Jan 2022 06:38:44 -0500
Received: from mail-qv1-f41.google.com ([209.85.219.41]:39567 "EHLO
        mail-qv1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbiAMLio (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Jan 2022 06:38:44 -0500
Received: by mail-qv1-f41.google.com with SMTP id p12so6291812qvj.6
        for <linux-acpi@vger.kernel.org>; Thu, 13 Jan 2022 03:38:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UyNZK+EBmGgdVhwBKX3XubAW7nsSSakp74tQxsMc3WI=;
        b=vuLZhMkYODsV+porP57kpTHXegX0XoSRFPolxdW9CtcN7Keclydt1ZWb6i5YVQV5yi
         pJe2bhaQSNNX7JAnp8lDaxAqLaV8QoX459KD+t0fkdEjQDzWMAsMvVERKYHNc77SSk0q
         sqNQKZZP21jpsezZL/SjOLaAC4WstiM/Wh6mWeJrQXBn8XuqmgtFeoL1pS6rIWh/MNRe
         TbDO2+Kz6HqDdKvnGHW89vqB507A5HuPiepyaY2nnYorOYmYB0eDPRe3YaqYVHZbX8Wt
         d5gRIVKTq6HHjPjjh61zuaWdGL+ia+fUKq9lNiNf5KJ4ByMhjh/he9UYXKytkFj2ZSez
         7s7g==
X-Gm-Message-State: AOAM532Yx6L8CE36pO5a4Obccxshf7fUFYuDGEuKKv0qGudai8QQFnOH
        zbbhlXwRehD6GWJegZbsIZJ3jd9+SkdRv2vRug6FJ5/4
X-Google-Smtp-Source: ABdhPJwofNRw7BFlMllXlQ09Lm3rdOAAxE4RdHC2cH0DMANMjr5dNH23Vikx1SBh2NQQtQxtrLAaPNzVzVo3MBBsnH8=
X-Received: by 2002:a05:6214:518e:: with SMTP id kl14mr3287768qvb.130.1642073923886;
 Thu, 13 Jan 2022 03:38:43 -0800 (PST)
MIME-Version: 1.0
References: <198c0ae2-efdf-7f47-11c7-27e9a87b3f32@boldcoder.com>
In-Reply-To: <198c0ae2-efdf-7f47-11c7-27e9a87b3f32@boldcoder.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Jan 2022 12:38:32 +0100
Message-ID: <CAJZ5v0gQhGEAdUte6wUQLr_7siL=yJ+YwwjNTMjrB6f41CXo0A@mail.gmail.com>
Subject: Re: Patch: Make ACPI subsystem provide CEDT table
To:     Robert Kiraly <me@boldcoder.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Dan,

On Thu, Jan 13, 2022 at 12:16 AM Robert Kiraly <me@boldcoder.com> wrote:
>
> This is a simple ACPI patch. I'm submitting a revised version to
> linux-acpi as opposed to linux-pm at Rafael Wysocki's suggestion.
>
> The patch adds ACPI_SIG_CEDT to table_sigs[] in "drivers/acpi/tables.c".
>
> The change will probably be made by upstream later regardless. But I've
> reviewed cxl-next and it doesn't seem to be present there yet.
>
> Presently, CXL code isn't able to make use of the CEDT table. Subsequent
> to the change, the CEDT table can be used.
>
> If a developer plans to use the CEDT table to program the CXL ports,
> this change is needed. Otherwise, it isn't expected to make a difference.

What do you think about this?
