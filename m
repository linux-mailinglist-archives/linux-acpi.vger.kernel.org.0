Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D82A127063
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2019 23:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfLSWHI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Dec 2019 17:07:08 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43043 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfLSWHI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Dec 2019 17:07:08 -0500
Received: by mail-ot1-f67.google.com with SMTP id p8so9056809oth.10
        for <linux-acpi@vger.kernel.org>; Thu, 19 Dec 2019 14:07:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ROtTYN3DgiUS/zLDy0/kWkZBId8MNTfGBSe8X0AnwGI=;
        b=qxNT61E2h0QpO43Ul3GOTfFgNkshgrq6GLOC4M13lCrVo+k0d8alscVquf2T+mpllW
         n/ZCTGzVXAFj4MP6GXzfWDfpNBrKUFgxlTcciBDN9DQpwxcxGeRJpO2NHgC8BZx7ElxU
         M4Oiwmwzf94QaX3xUC8OuRHoLUwaVyOfojC2r8J2J00NKfGysoBfB9IFNd5e4DgYgx5l
         ruvOTIrGx7ZR8KewrnIznYknaGVAmVATrPnonmACF9ZsJFYO1dGKOb7Ie48aRZYixqDP
         e30eDI0QA9i53kSHM+Aa/YPrbm0bceQPSMwg9K2U6alQ2JPlYck0GuMgEVor2fBZBDOj
         WxXA==
X-Gm-Message-State: APjAAAWNEpQ87rxU+V3WLtmOxuT3jtKovm6zkNPVfvbm6N08fNEeWNf5
        ulEwV76MF8f1bzuEqL0f2ymp2ptXIuZuw9GLLb8qKA==
X-Google-Smtp-Source: APXvYqw134YQllMKccE/2LPbXW4UlezFBSM6D2pq7qcopTxkoCn2LGl/PF9w6jrNp3dsdgJQ5lIo/JEK5JV7/3QW6bI=
X-Received: by 2002:a05:6830:4b9:: with SMTP id l25mr11487671otd.266.1576793227494;
 Thu, 19 Dec 2019 14:07:07 -0800 (PST)
MIME-Version: 1.0
References: <20191217193523.20204-1-erik.kaneda@intel.com>
In-Reply-To: <20191217193523.20204-1-erik.kaneda@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Dec 2019 23:06:56 +0100
Message-ID: <CAJZ5v0gKnm54krbT64kWvioVspFMz1NwTxS_OWHiGkF96ysegg@mail.gmail.com>
Subject: Re: [PATCH 0/5] ACPICA version 20191213 patches
To:     Erik Kaneda <erik.kaneda@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 17, 2019 at 8:55 PM Erik Kaneda <erik.kaneda@intel.com> wrote:
>
> This patchset contains a linux-ized patchset of the 20191213 release of
> ACPICA. Notable patches include Maximilan Luz's change to the AML
> interpreter to always treat buffer fields created from the ASL
> CreateField() operator as buffers rather than treating it as an integer
> if the buffer field is small enough to fit an integer. Other than that,
> there is a disassembler change to properly disassemble references to
> buffer fields that share the same namesegment as a method.
>
> This patchset is also available at the following link:
> https://github.com/SchmErik/linux/tree/20191213
>
> Bob Moore (1):
>   ACPICA: Update version to 20191213
>
> Colin Ian King (1):
>   ACPICA: debugger: fix spelling mistake "adress" -> "address"
>
> Erik Kaneda (2):
>   ACPICA: Disassembler: create buffer fields in ACPI_PARSE_LOAD_PASS1
>   ACPICA: acpisrc: add unix line ending support for non-windows build
>
> Maximilian Luz (1):
>   ACPICA: Dispatcher: always generate buffer objects for ASL
>     create_field() operator

Applying the whole series as 5.6 material, thanks!
