Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352B91C056B
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Apr 2020 20:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgD3S6c (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Apr 2020 14:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgD3S6a (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Apr 2020 14:58:30 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21792C035494
        for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2020 11:58:30 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id re23so5576005ejb.4
        for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2020 11:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VO82Y+ddPqwVbejb8yp1YADHo+TiaduERH1aUXgFNdU=;
        b=ftYR3vvy7y4XQUHnig2EWsnYgRjVl+CPW2em4ftSq034hx6ZoqSueCcso+RG9w8AGa
         w0/+YALKEw0FIaP05V+9C0XKOYuOmd59KAW1siA/r09GzwZUf48N8GmxNx1dxSbliixs
         CuBWjC2ORmo5GZgQNulH0b+ykeGy5IQzQog4ZcfdBGWxbr/kGwbKqiBi3jZCbBsGvnNW
         Q5W2E6yv533qZlcTHc6rxcPndCCEwjOVK0cZ2rz6LGVrs0kCEepYAF9z3xs1VIBjMZtf
         A5p7YNgqSxKHyCub+EuUXAZ2xuX50SSxRFhOGGuo9nNwQKHccsh0XWdv0oNDM0uH1ryy
         dbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VO82Y+ddPqwVbejb8yp1YADHo+TiaduERH1aUXgFNdU=;
        b=PnIX+tyCL1clG4c3GsuYIf6LPR3bhQ19XELSO3LeJKp2RWHGocMZtg1/6xt+w3uwhB
         8tfx5yUebVoXgZJHivQzm5HfujfadF8/QUe1bSMd4Ozn15fTZCJC1pOHKhQlgj2P5Fwh
         Dbz4mOcwxfOAgWOCVdkNSnIiTVikxRFx7wGdrJnkf9TFvvClybkLISBSbIcmsHMNsfTg
         Okz82xnmPxbaFLQPuZNe5UvwDm0bQhJMXtYlGFA/XoVbL4hn/5opNvn065E71nBVE3Az
         CMlFHj9OZONLKFKWGV4Lt4N7LQwDtBWbRGnvYXSfrpka9bcGqCq/Ub2mjilUUv2R6otK
         grdg==
X-Gm-Message-State: AGi0PuaPMC7woWQsUDJMjc3yiZzJGdzSmfcbWfC220YVkIrZwnD8O14o
        6isxqleTHCD+gcBMwS5p1Osiwdag6sT/pRbVqXIHgsM+
X-Google-Smtp-Source: APiQypLtO6lmgP+/t4n/a1LprqtsF2znfD77bnYaqHJRks9KFzncsFlKVdj99iACRR541U4ie6ERYFDj3Eno6uEUPdw=
X-Received: by 2002:a17:906:855a:: with SMTP id h26mr4305126ejy.56.1588273108788;
 Thu, 30 Apr 2020 11:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200430102908.10107-1-david@redhat.com> <20200430102908.10107-3-david@redhat.com>
 <87pnbp2dcz.fsf@x220.int.ebiederm.org> <1b49c3be-6e2f-57cb-96f7-f66a8f8a9380@redhat.com>
 <871ro52ary.fsf@x220.int.ebiederm.org> <373a6898-4020-4af1-5b3d-f827d705dd77@redhat.com>
 <875zdg26hp.fsf@x220.int.ebiederm.org> <b28c9e02-8cf2-33ae-646b-fe50a185738e@redhat.com>
In-Reply-To: <b28c9e02-8cf2-33ae-646b-fe50a185738e@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 30 Apr 2020 11:58:16 -0700
Message-ID: <CAPcyv4j33bwbrFMu2L0knRGRN1RDiC5kbknMNEwo-OFmPSw47w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm/memory_hotplug: Introduce MHP_NO_FIRMWARE_MEMMAP
To:     David Hildenbrand <david@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-hyperv@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Baoquan He <bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 30, 2020 at 11:44 AM David Hildenbrand <david@redhat.com> wrote:
>
>  >>> If the class of memory is different then please by all means let's mark
> >>> it differently in struct resource so everyone knows it is different.
> >>> But that difference needs to be more than hotplug.
> >>>
> >>> That difference needs to be the hypervisor loaned us memory and might
> >>> take it back at any time, or this memory is persistent and so it has
> >>> these different characteristics so don't use it as ordinary ram.
> >>
> >> Yes, and I think kmem took an excellent approach of explicitly putting
> >> that "System RAM" into a resource hierarchy. That "System RAM" won't
> >> show up as a root node under /proc/iomem (see patch #3), which already
> >> results in kexec-tools to treat it in a special way. I am thinking about
> >> doing the same for virtio-mem.
> >
> > Reading this and your patch cover letters again my concern is that
> > the justification seems to be letting the tail wag the dog.
> >
> > You want kexec-tools to behave in a certain way so you are changing the
> > kernel.
> >
> > Rather it should be change the kernel to clearly reflect reality and if
> > you can get away without a change to kexec-tools that is a bonus.
> >
>
> Right, because user space has to have a way to figure out what to do.
>
> But talking about the firmware memmap, indicating something via a "raw
> firmware-provided memory map", that is not actually in the "raw
> firmware-provided memory map" feels wrong to me. (below)
>
>
> >>> That information is also useful to other people looking at the system
> >>> and seeing what is going on.
> >>>
> >>> Just please don't muddle the concepts, or assume that whatever subset of
> >>> hotplug memory you are dealing with is the only subset.
> >>
> >> I can certainly rephrase the subject/description/comment, stating that
> >> this is not to be used for ordinary hotplugged DIMMs - only when the
> >> device driver is under control to decide what to do with that memory -
> >> especially when kexec'ing.
> >>
> >> (previously, I called this flag MHP_DRIVER_MANAGED, but I think
> >> MHP_NO_FIRMWARE_MEMMAP is clearer, we just need a better description)
> >>
> >> Would that make it clearer?
> >
> > I am not certain, but Andrew Morton deliberately added that
> > firmware_map_add_hotplug call.  Which means that there is a reason
> > for putting hotplugged memory in the firmware map.
> >
> > So the justification needs to take that reason into account.  The
> > justification can not be it is hotplugged therefore it should not belong
> > in the firmware memory map.  Unless you can show that
> > firmware_map_add_hotplug that was actually a bug and should be removed.
> > But as it has been that way since 2010 that seems like a long shot.
> >
> > So my question is what is right for the firmware map?
>
> We have documentation for that since 2008. Andrews patch is from 2010.
>
> Documentation/ABI/testing/sysfs-firmware-memmap
>
> It clearly talks about "raw firmware-provided memory map" and why the
> interface was introduced at all ("on most architectures that
> firmware-provided memory map is modified afterwards by the kernel itself").
>
> >
> > Why does the firmware map support hotplug entries?
>
> I assume:
>
> The firmware memmap was added primarily for x86-64 kexec (and still, is
> mostly used on x86-64 only IIRC). There, we had ACPI hotplug. When DIMMs
> get hotplugged on real HW, they get added to e820. Same applies to
> memory added via HyperV balloon (unless memory is unplugged via
> ballooning and you reboot ... the the e820 is changed as well). I assume
> we wanted to be able to reflect that, to make kexec look like a real reboot.

I can at least say that this breakdown makes sense to me. Traditional
memory hotplug results in permanent change to the raw firmware memory
map reported by the host at next reboot. These device-driver-owned
memory regions really want a hotplug policy per-kernel boot instance
and should fall back to the default reserved state at reboot (kexec or
otherwise). When I say hotplug-policy I mean whether the current
kernel wants to treat the device range as System RAM or leave it as
device-managed. The intent is that the follow-on kernel needs to
re-decide the device policy.

>
> This worked for a while. Then came dax/kmem. Now comes virtio-mem.
>
