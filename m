Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3C837FE0A
	for <lists+linux-acpi@lfdr.de>; Thu, 13 May 2021 21:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhEMT2K (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 May 2021 15:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhEMT2J (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 May 2021 15:28:09 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20478C061574
        for <linux-acpi@vger.kernel.org>; Thu, 13 May 2021 12:26:59 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id h4so40075746lfv.0
        for <linux-acpi@vger.kernel.org>; Thu, 13 May 2021 12:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TcTyI8CdqDYS+DLvWcEReUWNJFD/4vgGxlJYUQdhn98=;
        b=bVD78BCgzVDTYgRpvMwtI20LjNpcjZE4ug8fPOgkwqZd8jPUisd3g4ekz2la/BIgHF
         Czg4XeaVQmqDGXkKSjeQpbpG9NqHyTVkGlTnstlgeaSofhF4+VrLOdKZbBJv/BeqO9zC
         gfVjgew5vXKeNkTAz5Fed195VIoW0t04HzU/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TcTyI8CdqDYS+DLvWcEReUWNJFD/4vgGxlJYUQdhn98=;
        b=sP4PBRxsVZGUWUkPUgOLL8fECWiVU288IAqZgJM5ExDhXJkXXy2vQzhxpu/bO+MaAK
         lwPVAYSw/voPbuifdRMqJdaBUEDsbginotdvbx6QkFPtX9MY3jJvOwUety1EzW1Kn9co
         laat4CCfk/8dNQ3kMfYjHkoDLnXg4fVV9tzbuU3QgeasZaJJHx20NH+PowkW3PThmWIs
         BmOCXemsaLrSVjcG8SXNTZ/t23yShaUe8bIT1yK07MD3rCntiIeGyZmtvB2xlBmHyqu5
         I5q1BZNBHeFpok2tzF3LaAief9WaFYaSsiwbnPNNHxW8mEy5t6C2X+J2KcAz3mEzou14
         VDyQ==
X-Gm-Message-State: AOAM530m+ZA7F0ul8GWnBpK5IoUR/E3q331Fv0ONXkHYyrfKxmHPD/Zs
        dYCDg2CDwQxcgUfCanQK22nQwoJubRBDKWpK
X-Google-Smtp-Source: ABdhPJwFO8uReI76Or8xo6cBkn2fcocVOVa0cVV62uwSjuD7M9gTE20p9Rju1XEBrlIR943K0zgAKA==
X-Received: by 2002:a05:6512:3233:: with SMTP id f19mr30953640lfe.350.1620934017348;
        Thu, 13 May 2021 12:26:57 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 81sm377606lfc.300.2021.05.13.12.26.56
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 12:26:57 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id y9so35074693ljn.6
        for <linux-acpi@vger.kernel.org>; Thu, 13 May 2021 12:26:56 -0700 (PDT)
X-Received: by 2002:a2e:c52:: with SMTP id o18mr3512611ljd.411.1620934016634;
 Thu, 13 May 2021 12:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0in2AeuGt-YRjKE5r4AKhu1kTf=zRfFWfb+cPFZL-NESA@mail.gmail.com>
In-Reply-To: <CAJZ5v0in2AeuGt-YRjKE5r4AKhu1kTf=zRfFWfb+cPFZL-NESA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 13 May 2021 12:26:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjSF1Vozzmst-H_xgy20XZx0t55uBwn8B6Rqjhe0JfOwA@mail.gmail.com>
Message-ID: <CAHk-=wjSF1Vozzmst-H_xgy20XZx0t55uBwn8B6Rqjhe0JfOwA@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v5.13-rc2
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 13, 2021 at 12:06 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> These revert an unnecessary revert of an ACPI power management
> commit

I think it would be kind of nice to see more of an explanation than
"was not necessary".

The original report of problems was apparently wrong - but it would
maybe have been good to just mention how that all went down..

                Linus
