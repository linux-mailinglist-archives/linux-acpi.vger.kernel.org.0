Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDBB1F7407
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jun 2020 08:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgFLGqu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Jun 2020 02:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgFLGqu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Jun 2020 02:46:50 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA63C03E96F;
        Thu, 11 Jun 2020 23:46:49 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 25so7744085oiy.13;
        Thu, 11 Jun 2020 23:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=293SJMmZmVCGOunUSuOi65UyFjlasgM11ygVhvjbjJQ=;
        b=Tgg4peMLB7HLe6fFzbX/bV38F19jJEw53LDr4gqmFzn0YdXeuXOBeE7/tbUN1ftDeF
         5rqmhuRCjRXHuyowOnRl60WM9rnRIuAse0pD0eEpcgXlTlJ1banSdeS4jWgxwDO+GIkc
         gDG3k8FUED4MjtDIzYUjZdWUgVei6K8wprT1bZXLLkrshifcZqZnfJudi8bvYag52B6A
         c1XPT48eteML5JkQ1yYtstkCoqNVP0lc2WWI3X0o05SSzG47haIhXpuGqJobAx4egBkj
         1ymaPgXgOpJwsqs0t8sQndl9XCc8bdKFoHO/JbRn1PfAFFTHNNmyvwAA9VsvnoOufWY4
         n7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=293SJMmZmVCGOunUSuOi65UyFjlasgM11ygVhvjbjJQ=;
        b=TTYk1qGvKB2xw9L5YuuOdVhGU8kp9SAjppxAIWYi9r0mE9Hz/eNWczjqU2FAh0nD0z
         r8myTJrMpZE4ys65aVuSCKeSHW/IdPu+WaFLY4rfXdQA5OOzfZ7/sOiamcXnnEysfRsv
         7wWosARRYz6nshEhTuPGLwqDHCenlV4ho9qdvhrJij/7gG8Bmy5sLDHPTSc4PLdYpT+Z
         jZ1Hsyc41uNcvDbIQF56QGbGfXYhozMeezJxhgyeZ60LMLP1BcrYXKv0SxrKSbmKwoQM
         s1yQCUAOZxJJTjicYhS3fRsKFs7bix9j25wou2+aJqEVrcR66GqQXWGwg4vP4LXGsip0
         ULpA==
X-Gm-Message-State: AOAM531/I5ofjRyeTyWVdtYKitvhZ4hx4AMQJl1Tik572A0tP9u0wATh
        iS6loZq+TH554qehkmR/2JE=
X-Google-Smtp-Source: ABdhPJyDpZTY3Hr/oyAfz5V+2fGR2ae7hl9bs3HHZ91XwAvggeW+B3teTT2a4uUuMhadvnHdXaB2yw==
X-Received: by 2002:aca:438a:: with SMTP id q132mr623443oia.44.1591944408956;
        Thu, 11 Jun 2020 23:46:48 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id v2sm853810oib.26.2020.06.11.23.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 23:46:48 -0700 (PDT)
Date:   Thu, 11 Jun 2020 23:46:47 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>,
        yuu ichii <byahu140@heisei.be>
Subject: Re: [PATCH] ACPI: sysfs: Fix pm_profile_attr type
Message-ID: <20200612064647.GA34712@ubuntu-n2-xlarge-x86>
References: <20200612045149.1837-1-natechancellor@gmail.com>
 <202006112217.2E6CE093@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006112217.2E6CE093@keescook>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 11, 2020 at 11:17:14PM -0700, Kees Cook wrote:
> On Thu, Jun 11, 2020 at 09:51:50PM -0700, Nathan Chancellor wrote:
> > When running a kernel with Clang's Control Flow Integrity implemented,
> > there is a violation that happens when accessing
> > /sys/firmware/acpi/pm_profile:
> > 
> > $ cat /sys/firmware/acpi/pm_profile
> > 0
> > 
> > $ dmesg
> > ...
> > [   17.352564] ------------[ cut here ]------------
> > [   17.352568] CFI failure (target: acpi_show_profile+0x0/0x8):
> > [   17.352572] WARNING: CPU: 3 PID: 497 at kernel/cfi.c:29 __cfi_check_fail+0x33/0x40
> > [   17.352573] Modules linked in:
> > [   17.352575] CPU: 3 PID: 497 Comm: cat Tainted: G        W         5.7.0-microsoft-standard+ #1
> > [   17.352576] RIP: 0010:__cfi_check_fail+0x33/0x40
> > [   17.352577] Code: 48 c7 c7 50 b3 85 84 48 c7 c6 50 0a 4e 84 e8 a4 d8 60 00 85 c0 75 02 5b c3 48 c7 c7 dc 5e 49 84 48 89 de 31 c0 e8 7d 06 eb ff <0f> 0b 5b c3 00 00 cc cc 00 00 cc cc 00 85 f6 74 25 41 b9 ea ff ff
> > [   17.352577] RSP: 0018:ffffaa6dc3c53d30 EFLAGS: 00010246
> > [   17.352578] RAX: 331267e0c06cee00 RBX: ffffffff83d85890 RCX: ffffffff8483a6f8
> > [   17.352579] RDX: ffff9cceabbb37c0 RSI: 0000000000000082 RDI: ffffffff84bb9e1c
> > [   17.352579] RBP: ffffffff845b2bc8 R08: 0000000000000001 R09: ffff9cceabbba200
> > [   17.352579] R10: 000000000000019d R11: 0000000000000000 R12: ffff9cc947766f00
> > [   17.352580] R13: ffffffff83d6bd50 R14: ffff9ccc6fa80000 R15: ffffffff845bd328
> > [   17.352582] FS:  00007fdbc8d13580(0000) GS:ffff9cce91ac0000(0000) knlGS:0000000000000000
> > [   17.352582] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   17.352583] CR2: 00007fdbc858e000 CR3: 00000005174d0000 CR4: 0000000000340ea0
> > [   17.352584] Call Trace:
> > [   17.352586]  ? rev_id_show+0x8/0x8
> > [   17.352587]  ? __cfi_check+0x45bac/0x4b640
> > [   17.352589]  ? kobj_attr_show+0x73/0x80
> > [   17.352590]  ? sysfs_kf_seq_show+0xc1/0x140
> > [   17.352592]  ? ext4_seq_options_show.cfi_jt+0x8/0x8
> > [   17.352593]  ? seq_read+0x180/0x600
> > [   17.352595]  ? sysfs_create_file_ns.cfi_jt+0x10/0x10
> > [   17.352596]  ? tlbflush_read_file+0x8/0x8
> > [   17.352597]  ? __vfs_read+0x6b/0x220
> > [   17.352598]  ? handle_mm_fault+0xa23/0x11b0
> > [   17.352599]  ? vfs_read+0xa2/0x130
> > [   17.352599]  ? ksys_read+0x6a/0xd0
> > [   17.352601]  ? __do_sys_getpgrp+0x8/0x8
> > [   17.352602]  ? do_syscall_64+0x72/0x120
> > [   17.352603]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [   17.352604] ---[ end trace 7b1fa81dc897e419 ]---
> > 
> > When /sys/firmware/acpi/pm_profile is read, sysfs_kf_seq_show is called,
> > which in turn calls kobj_attr_show, which gets the ->show callback
> > member by calling container_of on attr (casting it to struct
> > kobj_attribute) then calls it.
> > 
> > There is a CFI violation because pm_profile_attr is of type
> > struct device_attribute but kobj_attr_show calls ->show expecting it
> > to be from struct kobj_attribute. CFI checking ensures that function
> > pointer types match when doing indirect calls. Fix pm_profile_attr to
> > be defined in terms of kobj_attribute so there is no violation or
> > mismatch.
> > 
> > Fixes: 362b646062b2 ("ACPI: Export FADT pm_profile integer value to userspace")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1051
> > Reported-by: yuu ichii <byahu140@heisei.be>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/acpi/sysfs.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> > index 3a89909b50a6..76c668c05fa0 100644
> > --- a/drivers/acpi/sysfs.c
> > +++ b/drivers/acpi/sysfs.c
> > @@ -938,13 +938,13 @@ static void __exit interrupt_stats_exit(void)
> >  }
> >  
> >  static ssize_t
> > -acpi_show_profile(struct device *dev, struct device_attribute *attr,
> > +acpi_show_profile(struct kobject *kobj, struct kobj_attribute *attr,
> >  		  char *buf)
> >  {
> >  	return sprintf(buf, "%d\n", acpi_gbl_FADT.preferred_profile);
> >  }
> >  
> > -static const struct device_attribute pm_profile_attr =
> > +static const struct kobj_attribute pm_profile_attr =
> >  	__ATTR(pm_profile, S_IRUGO, acpi_show_profile, NULL);
> 
> My mind absolutely rebelled at how this could not have been caught
> at compile time nor runtime already. Everything appears to be wrong
> here. It's a different structure, it's getting assigned, it's getting
> called! And then I went looking and started to scream. Apologies if this
> investigation is redundant to a thread I didn't see...

Yes, I was rather shocked as well... There was no prior discussion to
this patch, just something that was reported to me (the initial
reproducer was 'grep -irl uname /sys').

> First, __ATTR(), like most static initializer macros, is not typed.
> Normally this is okay because different structures have different
> members, so it wouldn't compile. But not in this case here. Everything
> assigned by __ATTR exists in both because ... they have an identical set
> of structure member names:
> 
> struct device_attribute {
>         struct attribute        attr;
>         ssize_t (*show)(struct device *dev, struct device_attribute *attr,
>                         char *buf);
>         ssize_t (*store)(struct device *dev, struct device_attribute *attr,
>                          const char *buf, size_t count);
> };
> 
> struct kobj_attribute {
>         struct attribute attr;
>         ssize_t (*show)(struct kobject *kobj, struct kobj_attribute *attr,
>                         char *buf);
>         ssize_t (*store)(struct kobject *kobj, struct kobj_attribute *attr,
>                          const char *buf, size_t count);
> };
> 
> But the show and store are different prototypes, so surely any variable
> assignments or argument passing would catch the mismatch. But no!
> The sysfs API only takes the .attr member address:
> 
>         result = sysfs_create_file(acpi_kobj, &pm_profile_attr.attr);
> 
> and, of course, that doesn't break because both struct device_attribute
> and struct kobj_attribute do, in fact, use the same structure for their
> .attr (struct attribute).
> 
> But here's the kicker:
> 
> static ssize_t kobj_attr_show(struct kobject *kobj, struct attribute *attr,
>                               char *buf)
> {
>         struct kobj_attribute *kattr;
>         ssize_t ret = -EIO;
> 
>         kattr = container_of(attr, struct kobj_attribute, attr);
>         if (kattr->show)
>                 ret = kattr->show(kobj, kattr, buf);
> 	...
> 
> A container_of() is used to calculate the offset. This doesn't explode
> (normally) at runtime because, as established, these structures have the
> same layout, so .show is in the same place.

Yes, this is all what I noticed as well (and tried to summarize in my
commit message, hopefully it made sense).

> Some thoughts that I am terrified to check or attempt, but I can't help
> myself:
> 
> 1) Is __ATTR() regularly used to perform cross-structure initialization?
> 
> Answer appears to be "yes":
> 
> include/linux/device.h: struct device_attribute dev_attr_##_name = __ATTR_WO(_name)
> include/linux/device/bus.h:     struct bus_attribute bus_attr_##_name = __ATTR_RW(_name)
> 
> 2) Should static initializer macros be typed to catch bad cross-type
>    assignments? (Which depends on "1" being "no".)
> 
> Changing this looks very hard, but it does make me wonder about doing
> stuff like this for static initializer macros:
> 
> -#define __ATTR(_name, _mode, _show, _store) { \
> +#define __ATTR(_name, _mode, _show, _store) (struct kobject *) { \
> 
> Obviously not possible here, though.
> 
> 3) This cannot possibly be the only case of this. Given the answer to
>    #1, this bug must be endemic.
> 
> static inline int __must_check sysfs_create_file(struct kobject *kobj,
>                                                  const struct attribute *attr)
> {
>         return sysfs_create_file_ns(kobj, attr, NULL);
> }
> 
> $ git grep 'sysfs_create_file.*, &.*\.attr' | wc -l
> 51
> 
> 16 appear to actually be kobj_attribute. Those are fine.
> 
> Similar to the patch above, 9 more are from DEVICE_ATTR() (named
> "dev_attr_$foo):
> 
> #define DEVICE_ATTR(_name, _mode, _show, _store) \
>         struct device_attribute dev_attr_##_name = __ATTR(_name, _mode, _show, _store)
> 
> And a here are a bunch more macro-based ones:
> 
> class_attr	is struct class_attribute
> 
> mdev_type_attr	is struct mdev_type_attribute
> 
> format_attr	is half struct device_attribute and half struct kobj_attribute:
> 
> arch/x86/events/amd/uncore.c:static struct device_attribute format_attr_##_dev##_name = __ATTR_RO(_dev);
> arch/x86/events/intel/cstate.c:static struct kobj_attribute format_attr_##_var =                \
> arch/x86/events/intel/uncore.h:static struct kobj_attribute format_attr_##_var =                   \
> arch/x86/events/rapl.c:static struct kobj_attribute format_attr_##_var = \
> drivers/perf/thunderx2_pmu.c:static struct device_attribute format_attr_##_var =                   \
> include/linux/perf_event.h:static struct device_attribute format_attr_##_name = __ATTR_RO(_name)
> 
> These 2 are also not kobj_attribute:
> 
> include/linux/module.h:extern struct module_attribute module_uevent;
> kernel/module.c:struct module_attribute module_uevent =
> 
> I think all of these non-kobj_attribute cases will trip CFI too, and
> this design pattern appears to be intentional. So that will be fun! :)
> 
> I haven't gone through all of the 51 carefully, but this looks like a
> much larger problem than just this one place. :(

Yikes... :/ that is going to be fun to fully uncover. I am interested in
seeing which ones I can get to trigger on real hardware.

Thanks for the full analysis, I should have probably added some more
myself.

Cheers,
Nathan
