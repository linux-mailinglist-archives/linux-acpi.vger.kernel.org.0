Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8063587C5
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Apr 2021 17:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhDHPFA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Apr 2021 11:05:00 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:35665 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhDHPEz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Apr 2021 11:04:55 -0400
Received: by mail-ot1-f50.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so2605891oto.2;
        Thu, 08 Apr 2021 08:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lz31zLZWAqCN/8o9830TFwS7tMhL2r4G2foyIgDy9Rc=;
        b=s51zz718Tpw6xGEVsvnqShsrDQAT/aNhIATHfXKIPXWwnFq2RPFXPJq1iqy7WHUPAb
         7Hgkjnd2xSMybuvEEb3rPS6sPSQJB3RuzB7QGdSjsX00xoR3LdtR+sWedGBZff/8IFHT
         s5vaatg0Gh1KX4/ovBu8lnjdm42FlQDF9JZbfKa9PqFUQ6in5VLL6rbDPw0cJvjSkwiP
         ZG+gvhuAECIsh5NxnD0IaNo0ZKksxHNsd+LwKzhFnb0xQ5qkb0JeQQahHEAhq0JPMjj9
         oDlg+d79btAftHGKJ34ZjCyte5yhku8BsR7kM4e24FtdkaMpOYSb0WcrUcw3F5OL9Jk6
         KZAw==
X-Gm-Message-State: AOAM530zahIRutyGUO2vJd8EUP8Z/l3hJRK61P5OCoA0b7hF5nZKQfkF
        hAqv/yD9iDoQWvlKCSRBOeo5LbW7iP6dF4SW280=
X-Google-Smtp-Source: ABdhPJz3KoxJanp0wZDxXk9EhO+2ND46HZ78Kw+J9fAjM5vdN7PwyWK8BDOj8yCHhbpr2450dX7BejS8n5of3oHlIZo=
X-Received: by 2002:a9d:4811:: with SMTP id c17mr8269736otf.206.1617894282947;
 Thu, 08 Apr 2021 08:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210329151207.36619-1-andriy.shevchenko@linux.intel.com>
 <YGRXmOMfCTxy31Rj@kuha.fi.intel.com> <CAJZ5v0jJCYD9+j57-CL-OqiZKL7bBQ7NetcewE_37wODOG_Jkg@mail.gmail.com>
 <YG8YSPHMBbBJadvp@smile.fi.intel.com>
In-Reply-To: <YG8YSPHMBbBJadvp@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Apr 2021 17:04:32 +0200
Message-ID: <CAJZ5v0j0XpD6mbaCxAjBARsiScSG2T0v_2m8NdrnoQVmsqDDXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] software node: Free resources explicitly when
 swnode_register() fails
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 8, 2021 at 4:50 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Apr 08, 2021 at 04:15:37PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Mar 31, 2021 at 1:06 PM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > On Mon, Mar 29, 2021 at 06:12:02PM +0300, Andy Shevchenko wrote:
> > > > Currently we have a slightly twisted logic in swnode_register().
> > > > It frees resources that it doesn't allocate on error path and
> > > > in once case it relies on the ->release() implementation.
> > > >
> > > > Untwist the logic by freeing resources explicitly when swnode_register()
> > > > fails. Currently it happens only in fwnode_create_software_node().
> > > >
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >
> > > It all looks OK to me. FWIW, for the whole series:
> > >
> > > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >
> > Whole series applied (with some minor changelog edits) as 5.13 material, thanks!
>
> It seems Greg applied it already. Was it dropped there?

Did he?

OK, so please let me know if it's still there in the Greg's tree.
