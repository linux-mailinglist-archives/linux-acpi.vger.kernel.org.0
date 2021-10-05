Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3887E421D4A
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Oct 2021 06:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhJEE0x (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Oct 2021 00:26:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:29482 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229659AbhJEE0x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 5 Oct 2021 00:26:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="286526865"
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; 
   d="scan'208";a="286526865"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 21:25:03 -0700
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; 
   d="scan'208";a="623256247"
Received: from yilai-mobl1.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.249.172.101])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 21:24:57 -0700
Date:   Tue, 5 Oct 2021 12:24:53 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] drivers/acpi: Introduce Platform Firmware Runtime
 Update device driver
Message-ID: <20211005042453.GC7134@chenyu5-mobl1>
References: <cover.1631802162.git.yu.c.chen@intel.com>
 <90d270c031401430445cb2c4ba1b9b0c265cf9d4.1631802163.git.yu.c.chen@intel.com>
 <CAJZ5v0i__g02rjQh5TuBQN2HejEbZUxiy-4=YSWDUEczrTui0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i__g02rjQh5TuBQN2HejEbZUxiy-4=YSWDUEczrTui0Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 28, 2021 at 02:22:28PM +0200, Rafael J. Wysocki wrote:
> On Thu, Sep 16, 2021 at 5:56 PM Chen Yu <yu.c.chen@intel.com> wrote:
[snip]
> > +static bool valid_cap_type(int idx, union acpi_object *obj)
> > +{
> > +       acpi_object_type type = obj->type;
> > +
> > +       if (idx == CAP_STATUS_IDX || idx == CAP_UPDATE_IDX ||
> > +           idx == CAP_FW_VER_IDX || idx == CAP_CODE_RT_VER_IDX ||
> > +           idx == CAP_DRV_RT_VER_IDX || idx == CAP_DRV_SVN_IDX)
> > +               return type == ACPI_TYPE_INTEGER;
> > +       else if (idx == CAP_CODE_TYPE_IDX || idx == CAP_DRV_TYPE_IDX ||
> > +                idx == CAP_PLAT_ID_IDX || idx == CAP_OEM_ID_IDX ||
> > +                idx == CAP_OEM_INFO_IDX)
> > +               return type == ACPI_TYPE_BUFFER;
> > +       else
> > +               return false;
> > +}
> 
> IMO, this is way overdesigned.  It is not necessary to do all of these
> checks for every element of the package in query_capability().
>
[snip] 
> It is not very useful to do a loop if there is a switch () on the
> control variable in every step.
> 
> > +               union acpi_object *obj = &out_obj->package.elements[i];
> > +
> > +               if (!valid_cap_type(i, obj))
> > +                       goto free_acpi_buffer;
> > +
> > +               switch (i) {
> > +               case CAP_STATUS_IDX:
> > +                       cap->status = obj->integer.value;
> > +                       break;
> 
> The above can be written as
> 
> if (out_obj->package.elements[CAP_STATUS_IDX].type != ACPI_TYPE_INTEGER)
>         goto free_acpi_buffer;
> 
> cap->status = out_obj->package.elements[CAP_STATUS_IDX].integer.value;
> 
> and analogously for all of the other index values.
> 
> But check the number of elements upfront.
> 
Ok, got it. The next version will combine above together, and eliminate
the loop, switch logic.
> > +               case CAP_UPDATE_IDX:
> > +                       cap->update_cap = obj->integer.value;
> > +                       break;
> > +               case CAP_CODE_TYPE_IDX:
> > +                       memcpy(&cap->code_type, obj->buffer.pointer,
> > +                              obj->buffer.length);
> > +                       break;
> > +               case CAP_FW_VER_IDX:
> > +                       cap->fw_version = obj->integer.value;
> > +                       break;
> > +               case CAP_CODE_RT_VER_IDX:
> > +                       cap->code_rt_version = obj->integer.value;
> > +                       break;
> > +               case CAP_DRV_TYPE_IDX:
> > +                       memcpy(&cap->drv_type, obj->buffer.pointer,
> > +                              obj->buffer.length);
> > +                       break;
> > +               case CAP_DRV_RT_VER_IDX:
> > +                       cap->drv_rt_version = obj->integer.value;
> > +                       break;
> > +               case CAP_DRV_SVN_IDX:
> > +                       cap->drv_svn = obj->integer.value;
> > +                       break;
> > +               case CAP_PLAT_ID_IDX:
> > +                       memcpy(&cap->platform_id, obj->buffer.pointer,
> > +                              obj->buffer.length);
> > +                       break;
> > +               case CAP_OEM_ID_IDX:
> > +                       memcpy(&cap->oem_id, obj->buffer.pointer,
> > +                              obj->buffer.length);
> > +                       break;
> > +               case CAP_OEM_INFO_IDX:
> > +                       /*vendor specific data*/
> > +                       break;
> > +               default:
> > +                       pr_err("Incorrect format of Update Capability.\n");
> 
> Why pr_err() and not dev_dbg()?
>
Will change to dev_dbg() in next version. 
> Besides, it looks like you're going to fail if the package has more
> elements than expected, but is this really a big deal?
> 
> Moreover, what if the number of package elements is too small?
> 
Ok, will change it to check if the number of package elements is larger/equals to
expected in the spec.
> > +                       goto free_acpi_buffer;
> > +               }
> > +       }
> > +       ret = 0;
> > +
> > +free_acpi_buffer:
> > +       ACPI_FREE(out_obj);
> > +
> > +       return ret;
> > +}
> > +
> > +static int query_buffer(struct pfru_com_buf_info *info)
> > +{
> > +       union acpi_object *out_obj;
> > +       acpi_handle handle;
> > +       int i, ret = -EINVAL;
> > +
> > +       handle = ACPI_HANDLE(pfru_dev->dev);
> > +       out_obj = acpi_evaluate_dsm_typed(handle, &pfru_dev->uuid,
> > +                                         pfru_dev->rev_id, FUNC_QUERY_BUF,
> > +                                         NULL, ACPI_TYPE_PACKAGE);
> > +       if (!out_obj)
> > +               return -EINVAL;
> > +
> > +       for (i = 0; i < out_obj->package.count; i++) {
> 
> Again, what is the benefit from doing this loop?
>
Will eliminate the loop in next version. 
[snip]
> > +
> > +static int get_image_type(efi_manage_capsule_image_header_t *img_hdr,
> > +                         int *type)
> > +{
> > +       guid_t *image_type_id;
> > +
> > +       /* check whether this is a code injection or driver update */
> > +       image_type_id = &img_hdr->image_type_id;
> 
> Anything wrong with doing this assignment as initialization?
> 
Ok, will change it in next version.
> > +       if (guid_equal(image_type_id, &pfru_dev->code_uuid))
> > +               *type = CODE_INJECT_TYPE;
> > +       else if (guid_equal(image_type_id, &pfru_dev->drv_uuid))
> > +               *type = DRIVER_UPDATE_TYPE;
> 
> And what would be wrong with returning the type or a negative error code?
> 
Will change it in next version.
> > +       else
> > +               return -EINVAL;
> > +
> > +       return 0;
> > +}
> > +
> > +/*
> > + * The (u64 hw_ins) was introduced in UEFI spec version 2,
> > + * and (u64 capsule_support) was introduced in version 3.
> > + * The size needs to be adjusted accordingly. That is to
> > + * say, version 1 should subtract the size of hw_ins+capsule_support,
> > + * and version 2 should sbstract the size of capsule_support.
> 
> Either turn this into a kerneldoc comment or put it inside the function.
> 
Will put it inside the function.
> > + */
> > +static int adjust_efi_size(efi_manage_capsule_image_header_t *img_hdr,
> > +                          int *size)
> > +{
> > +       int tmp_size = *size;
> > +
> > +       tmp_size += sizeof(efi_manage_capsule_image_header_t);
> > +       switch (img_hdr->ver) {
> > +       case 1:
> > +               tmp_size -= 2 * sizeof(u64);
> > +               break;
> > +       case 2:
> > +               tmp_size -= sizeof(u64);
> > +               break;
> > +       default:
> > +               /* only support version 1 and 2 */
> > +               return -EINVAL;
> > +       }
> > +       *size = tmp_size;
> 
> Why not simply return the size or a negative error code?
> 
Will change it in next version.
> > +
> > +       return 0;
> > +}
> > +
> > +/*
> > + * Sanity check if the capsule image has a newer version than current one.
> > + * Return: true if it is valid, false otherwise.
> 
> Would it hurt if this was a proper kerneldoc comment?
> 
Will put it inside the function.
[snip]
> > +
> > +static void dump_update_result(struct pfru_updated_result *result)
> > +{
> > +       pr_debug("Update result:\n");
> > +       pr_debug("Status:%d\n", result->status);
> > +       pr_debug("Extended Status:%d\n", result->ext_status);
> > +       pr_debug("Authentication Time Low:%lld\n", result->low_auth_time);
> > +       pr_debug("Authentication Time High:%lld\n", result->high_auth_time);
> > +       pr_debug("Execution Time Low:%lld\n", result->low_exec_time);
> > +       pr_debug("Execution Time High:%lld\n", result->high_exec_time);
> 
> All of these could be dev_dbg() I suppose?
>
Ok, will change it in next version. 
> > +}
> > +
> > +
[snip]
> > +       for (i = 0; i < out_obj->package.count; i++) {
> 
> Same comment regarding the benefit of doing a loop: why is it needed?
> 
Will remove the loop in next version.
[snip]
> > +
> > +       switch (cmd) {
> > +       case PFRU_IOC_SET_REV:
> > +               if (copy_from_user(&rev, p, sizeof(unsigned int)))
> > +                       return -EFAULT;
> > +               if (!pfru_valid_revid(rev))
> > +                       return -EFAULT;
> 
> Why is this the right error code to return here?
> 
Will change EFAULT to EINVAL in next version.
[snip]
> > +       /* map the communication buffer */
> > +       phy_addr = (phys_addr_t)(info.addr_lo | (info.addr_hi << 32));
> > +       buf_ptr = memremap(phy_addr, info.buf_size, MEMREMAP_WB);
> > +       if (IS_ERR(buf_ptr))
> > +               return PTR_ERR(buf_ptr);
> 
> Empty line here, please.
> 
Ok, will do.
> > +       if (!copy_from_iter_full(buf_ptr, len, &iter)) {
> > +               pr_err("error! could not read capsule file\n");
> 
> dev_dbg()?
> 
Ok, will change it in next version.
> > +               ret = -EINVAL;
> > +               goto unmap;
> > +       }
> > +
> > +       /* Check if the capsule header has a valid version number. */
> > +       ret = query_capability(&cap);
> > +       if (ret)
> > +               goto unmap;
> 
> ret is guaranteed to be 0 here, so you can do
> 
> if (cap.status != DSM_SUCCEED)
>         ret = -EBUSY;
> else if (!valid_version(buf_ptr, &cap))
>         ret = -EINVAL;
> 
> and the gotos and the "ret = 0" statement below won't be necessary.
> 
Ok, will do in next version.
[snip]
> > +static ssize_t pfru_read(struct file *filp, char __user *ubuf,
> > +                        size_t size, loff_t *off)
> > +{
> > +       struct pfru_update_cap_info cap;
> > +       int ret;
> > +
> > +       ret = query_capability(&cap);
> > +       if (ret)
> > +               return ret;
> > +
> > +       size = min_t(size_t, size, sizeof(cap));
> > +
> > +       if (copy_to_user(ubuf, &cap, size))
> > +               return -EFAULT;
> 
> Well, if the read() is only needed for this, maybe consider
> implementing it as an ioctl() command and using read() for the
> telemetry retrieval?  Then, you won't need the other special device
> file, the write() will be the code injection/update, the read() will
> be telemetry retrieval and all of the rest can be ioctl()s under one
> special device file.
> 
Got it, will try to combine the two modules into one.

thanks,
Chenyu
