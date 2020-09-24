Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87220277328
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Sep 2020 15:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgIXNzD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Sep 2020 09:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbgIXNzD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Sep 2020 09:55:03 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF2BC0613CE
        for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2020 06:55:02 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id gr14so4660940ejb.1
        for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2020 06:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u0Wwg44LAJ97oDid02lb/yWA2qTwaA94VroM35bUtxs=;
        b=fz2dCKCM6gYh+e67Fsuthj+EMQFSxTJF23dMNMiOXOgepOQmYJQnfdSExcrz7soelL
         wuGYNZKdLFhitgSzfhEAbih8kf0GQohxFDDfvtCoarw/kIX6KKuAnhbIRVPrjZz+n6q9
         d7WXqr4o/GJuJBLuNSYV3w85Bvj/ZTcO5YksdZItI0/vlU79FujjL8YoTvCEIOFoJTd/
         6vh4w4rlArULZPlhTQxbI54J/EVnN66/GrClQeJzzzAKB5VTq/3tEC1NP2kze3HRI0t1
         MDhjq+kPKXdETW6F6AFWe4S+sh4xowCGkxzQBf/hmAJjVKqUnIt8HIYWV/Xq13aVAWO5
         zV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u0Wwg44LAJ97oDid02lb/yWA2qTwaA94VroM35bUtxs=;
        b=fI8mAT5kejTdy9jKNLBG8bFN/w2Vi2yvRJO1E434h6MuF2klNNJNbhuxYfQy4S2xbJ
         Ni0OeWMi47OULfA1cwnaFwVe9vD1jWKjQ7kCIKOm2no9L+kgfoK/GQRtnqPWnrugxpI7
         Fm1//Yw4b2wT6Jh0WCzq9uId8yMnwuy4ko7J84W+EyPuhqeluDJGVeq8qaawn7ulP6RT
         FCcAyZL5i9eJ3v+UX6KECFtztGLn44AuiVsu4IfVj4MQLUSzboqxoeuSsNlMHo3EGD+p
         5+HhRZ8NmFHJSLn1arNN4SVwECDaZaG8lsZd9hq9yBKmmrSFw/tteXDk2kOozBvp4ycS
         fwVw==
X-Gm-Message-State: AOAM5327vBWWs12RHJTVXR2U07btRitjtT6tq8aYdwQR6HSHaISwaD7J
        SDrBsyf5lUQUP4clpgUJ/OCL2nYrd9WV0UFNQ36A8w==
X-Google-Smtp-Source: ABdhPJy+gShDa4M5BCxb6FmTsKMUNxD9KbnGrAI9AWRrw57kRj5wOs7HEgWWpD+B+1/E1a7KpQVWWVvv5CfNF8IG2sw=
X-Received: by 2002:a17:906:8143:: with SMTP id z3mr1107180ejw.323.1600955701310;
 Thu, 24 Sep 2020 06:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159643100485.4062302.976628339798536960.stgit@dwillia2-desk3.amr.corp.intel.com>
 <a3ad70a2-77a8-d50e-f372-731a8e27c03b@redhat.com> <17686fcc-202e-0982-d0de-54d5349cfb5d@oracle.com>
 <9acc6148-72eb-7016-dba9-46fa87ded5a5@redhat.com> <CAPcyv4h5GGV3F-0rFY_pyv9Bj8LAkrwXruxGE=K2y9=dA8oDHw@mail.gmail.com>
 <d160c05b-9caa-1ffb-9c01-5bb261c744b5@redhat.com>
In-Reply-To: <d160c05b-9caa-1ffb-9c01-5bb261c744b5@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 24 Sep 2020 06:54:49 -0700
Message-ID: <CAPcyv4jf9fK5oOcROMx=c-3q6aGFp89MNi-+GoZ-dy1gdNTrJw@mail.gmail.com>
Subject: Re: [PATCH v4 11/23] device-dax: Kill dax_kmem_res
To:     David Hildenbrand <david@redhat.com>
Cc:     Joao Martins <joao.m.martins@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 24, 2020 at 12:26 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 23.09.20 23:41, Dan Williams wrote:
> > On Wed, Sep 23, 2020 at 1:04 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 08.09.20 17:33, Joao Martins wrote:
> >>> [Sorry for the late response]
> >>>
> >>> On 8/21/20 11:06 AM, David Hildenbrand wrote:
> >>>> On 03.08.20 07:03, Dan Williams wrote:
> >>>>> @@ -37,109 +45,94 @@ int dev_dax_kmem_probe(struct device *dev)
> >>>>>      * could be mixed in a node with faster memory, causing
> >>>>>      * unavoidable performance issues.
> >>>>>      */
> >>>>> -   numa_node = dev_dax->target_node;
> >>>>>     if (numa_node < 0) {
> >>>>>             dev_warn(dev, "rejecting DAX region with invalid node: %d\n",
> >>>>>                             numa_node);
> >>>>>             return -EINVAL;
> >>>>>     }
> >>>>>
> >>>>> -   /* Hotplug starting at the beginning of the next block: */
> >>>>> -   kmem_start = ALIGN(range->start, memory_block_size_bytes());
> >>>>> -
> >>>>> -   kmem_size = range_len(range);
> >>>>> -   /* Adjust the size down to compensate for moving up kmem_start: */
> >>>>> -   kmem_size -= kmem_start - range->start;
> >>>>> -   /* Align the size down to cover only complete blocks: */
> >>>>> -   kmem_size &= ~(memory_block_size_bytes() - 1);
> >>>>> -   kmem_end = kmem_start + kmem_size;
> >>>>> -
> >>>>> -   new_res_name = kstrdup(dev_name(dev), GFP_KERNEL);
> >>>>> -   if (!new_res_name)
> >>>>> +   res_name = kstrdup(dev_name(dev), GFP_KERNEL);
> >>>>> +   if (!res_name)
> >>>>>             return -ENOMEM;
> >>>>>
> >>>>> -   /* Region is permanently reserved if hotremove fails. */
> >>>>> -   new_res = request_mem_region(kmem_start, kmem_size, new_res_name);
> >>>>> -   if (!new_res) {
> >>>>> -           dev_warn(dev, "could not reserve region [%pa-%pa]\n",
> >>>>> -                    &kmem_start, &kmem_end);
> >>>>> -           kfree(new_res_name);
> >>>>> +   res = request_mem_region(range.start, range_len(&range), res_name);
> >>>>
> >>>> I think our range could be empty after aligning. I assume
> >>>> request_mem_region() would check that, but maybe we could report a
> >>>> better error/warning in that case.
> >>>>
> >>> dax_kmem_range() already returns a memory-block-aligned @range but
> >>> IIUC request_mem_region() isn't checking for that. Having said that
> >>> the returned @res wouldn't be different from the passed range.start.
> >>>
> >>>>>     /*
> >>>>>      * Ensure that future kexec'd kernels will not treat this as RAM
> >>>>>      * automatically.
> >>>>>      */
> >>>>> -   rc = add_memory_driver_managed(numa_node, new_res->start,
> >>>>> -                                  resource_size(new_res), kmem_name);
> >>>>> +   rc = add_memory_driver_managed(numa_node, res->start,
> >>>>> +                                  resource_size(res), kmem_name);
> >>>>> +
> >>>>> +   res->flags |= IORESOURCE_BUSY;
> >>>>
> >>>> Hm, I don't think that's correct. Any specific reason why to mark the
> >>>> not-added, unaligned parts BUSY? E.g., walk_system_ram_range() could
> >>>> suddenly stumble over it - and e.g., similarly kexec code when trying to
> >>>> find memory for placing kexec images. I think we should leave this
> >>>> !BUSY, just as it is right now.
> >>>>
> >>> Agreed.
> >>>
> >>>>>     if (rc) {
> >>>>> -           release_resource(new_res);
> >>>>> -           kfree(new_res);
> >>>>> -           kfree(new_res_name);
> >>>>> +           release_mem_region(range.start, range_len(&range));
> >>>>> +           kfree(res_name);
> >>>>>             return rc;
> >>>>>     }
> >>>>> -   dev_dax->dax_kmem_res = new_res;
> >>>>> +
> >>>>> +   dev_set_drvdata(dev, res_name);
> >>>>>
> >>>>>     return 0;
> >>>>>  }
> >>>>>
> >>>>>  #ifdef CONFIG_MEMORY_HOTREMOVE
> >>>>> -static int dev_dax_kmem_remove(struct device *dev)
> >>>>> +static void dax_kmem_release(struct dev_dax *dev_dax)
> >>>>>  {
> >>>>> -   struct dev_dax *dev_dax = to_dev_dax(dev);
> >>>>> -   struct resource *res = dev_dax->dax_kmem_res;
> >>>>> -   resource_size_t kmem_start = res->start;
> >>>>> -   resource_size_t kmem_size = resource_size(res);
> >>>>> -   const char *res_name = res->name;
> >>>>>     int rc;
> >>>>> +   struct device *dev = &dev_dax->dev;
> >>>>> +   const char *res_name = dev_get_drvdata(dev);
> >>>>> +   struct range range = dax_kmem_range(dev_dax);
> >>>>>
> >>>>>     /*
> >>>>>      * We have one shot for removing memory, if some memory blocks were not
> >>>>>      * offline prior to calling this function remove_memory() will fail, and
> >>>>>      * there is no way to hotremove this memory until reboot because device
> >>>>> -    * unbind will succeed even if we return failure.
> >>>>> +    * unbind will proceed regardless of the remove_memory result.
> >>>>>      */
> >>>>> -   rc = remove_memory(dev_dax->target_node, kmem_start, kmem_size);
> >>>>> -   if (rc) {
> >>>>> -           any_hotremove_failed = true;
> >>>>> -           dev_err(dev,
> >>>>> -                   "DAX region %pR cannot be hotremoved until the next reboot\n",
> >>>>> -                   res);
> >>>>> -           return rc;
> >>>>> +   rc = remove_memory(dev_dax->target_node, range.start, range_len(&range));
> >>>>> +   if (rc == 0) {
> >>>>
> >>>> if (!rc) ?
> >>>>
> >>> Better off would be to keep the old order:
> >>>
> >>>       if (rc) {
> >>>               any_hotremove_failed = true;
> >>>               dev_err(dev, "%#llx-%#llx cannot be hotremoved until the next reboot\n",
> >>>                               range.start, range.end);
> >>>               return;
> >>>       }
> >>>
> >>>       release_mem_region(range.start, range_len(&range));
> >>>       dev_set_drvdata(dev, NULL);
> >>>       kfree(res_name);
> >>>       return;
> >>>
> >>>
> >>>>> +           release_mem_region(range.start, range_len(&range));
> >>>>
> >>>> remove_memory() does a release_mem_region_adjustable(). Don't you
> >>>> actually want to release the *unaligned* region you requested?
> >>>>
> >>> Isn't it what we're doing here?
> >>> (The release_mem_region_adjustable() is using the same
> >>> dax_kmem-aligned range and there's no split/adjust)
> >>>
> >>> Meaning right now (+ parent marked as !BUSY), and if I am understanding
> >>> this correctly:
> >>>
> >>> request_mem_region(range.start, range_len)
> >>>    __request_region(iomem_res, range.start, range_len) -> alloc @parent
> >>> add_memory_driver_managed(parent.start, resource_size(parent))
> >>>    __request_region(parent.start, resource_size(parent)) -> alloc @child
> >>>
> >>> [...]
> >>>
> >>> remove_memory(range.start, range_len)
> >>>  request_mem_region_adjustable(range.start, range_len)
> >>>   __release_region(range.start, range_len) -> remove @child
> >>>
> >>> release_mem_region(range.start, range_len)
> >>>   __release_region(range.start, range_len) -> doesn't remove @parent because !BUSY?
> >>>
> >>> The add/removal of this relies on !BUSY. But now I am wondering if the parent remaining
> >>> unreleased is deliberate even on CONFIG_MEMORY_HOTREMOVE=y.
> >>>
> >>>       Joao
> >>>
> >>
> >> Thinking about it, if we don't set the parent resource BUSY (which is
> >> what I think is the right way of doing things), and don't want to store
> >> the parent resource pointer, we could add something like
> >> lookup_resource() - e.g., lookup_mem_resource() - , however, searching
> >> properly in the whole hierarchy (instead of only the first level), and
> >> traversing down to the last hierarchy. Then it would be as simple as
> >>
> >> remove_memory(range.start, range_len)
> >> res = lookup_mem_resource(range.start);
> >> release_resource(res);
> >
> > Another thought... I notice that you've taught
> > register_memory_resource() a IORESOURCE_MEM_DRIVER_MANAGED special
> > case. Lets just make the assumption of add_memory_driver_managed()
> > that it is the driver's responsibility to mark the range busy before
> > calling, and the driver's responsibility to release the region. I.e.
> > validate (rather than request) that the range is busy in
> > register_memory_resource(), and teach release_memory_resource() to
> > skip releasing the region when the memory is marked driver managed.
> > That would let dax_kmem drop its manipulation of the 'busy' flag which
> > is a layering violation no matter how many comments we put around it.
>
> IIUC, that won't work for virtio-mem, whereby the parent resource spans
> multiple possible (future) add_memory_driver_managed() calls and is
> (just like for kmem) a pure indication to which device memory ranges belong.
>
> For example, when exposing 2GB via a virtio-mem device with max 4GB:
>
> (/proc/iomem)
> 240000000-33fffffff : virtio0
>   240000000-2bfffffff : System RAM (virtio_mem)
>
> And after hotplugging additional 2GB:
>
> 240000000-33fffffff : virtio0
>   240000000-33fffffff : System RAM (virtio_mem)
>
> So marking "virtio0" always BUSY (especially right from the start) would
> be wrong.

I'm not suggesting to busy the whole "virtio" range, just the portion
that's about to be passed to add_memory_driver_managed().

> The assumption is that anything that's IORESOURCE_SYSTEM_RAM
> and IORESOUCE_BUSY is currently added to the system as system RAM (e.g.,
> after add_memory() and friends, or during boot).
>
> I do agree that manually clearing the busy flag is ugly. What we most
> probably want is request_mem_region() that performs similar checks (no
> overlaps with existing BUSY resources), but doesn't set the region busy.
>

I can't see that working without some way to export and hold the
resource lock until some agent can atomically claim the range.
