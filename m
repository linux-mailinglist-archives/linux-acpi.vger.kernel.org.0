Return-Path: <linux-acpi+bounces-14030-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6BFAC96C8
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 22:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010561BC04D6
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 20:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77455218E81;
	Fri, 30 May 2025 20:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fGseEN0s"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7362116F5;
	Fri, 30 May 2025 20:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748638365; cv=none; b=Lb5FeZtpky6Si0LdLbD0vS1tD+Qy3l8bS5dUFcPJ/XKWsbtZs4QRpNVxqQ4MhbT2VCaos8LvxPNEr3VXnV03be7SDxOeLM1fbMrYP8DEnPBna4PAKpVXAKiXlh8mGojPPc1Z+o9cLfueYgSlTjkvqlNGI3rtV9O9n4o4zB404HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748638365; c=relaxed/simple;
	bh=6wD9qLU9InEHmkifduhSxAoPuEl6o3f+VKiVSxBDZfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpr5vqedrUitV/7x3Aj0DqPrn1HKpRJbekZIGi1B9MgNsmLol2EA/3KdT8C9UP1DkXoxtVqODC7zdcn9wDEt/WctFvKGuhOQk5idcl2mnCndtrz13bTlU94E1zwPAqydMLKbV+usrlbXwaqw18NH3rUNObZNts0pD31Jb6ShEYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fGseEN0s; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748638361; x=1780174361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6wD9qLU9InEHmkifduhSxAoPuEl6o3f+VKiVSxBDZfY=;
  b=fGseEN0sk5Bf82aIRvmpT8XyqVRLHDu+NHmUas6pM9MHruafCIg5PYEe
   hgrd0cMePcOu/kOZssi0r0JwkGqorADdVWACKhv/c7zuL2WwEx7N2ndId
   WSbsOsTQMMEMkZdXoklFdzar9T1J9yB7arvYlmgYbfK1sM86/3aA9J+90
   sudkjksf8Ol+GpTAwXkf/XDWLCJtdn18nkvPXBRtw0eV5qRAWYZ/dk9z+
   CKo8E0lAnJb9xOZYnF/G5fN2n4elbKoP2LoLXWuIIODSLNnR32PQymxvP
   x35vahBXUcKNkFJivvVRvIvpncxERCxOj/WFe6K8aSgPdGlJbYNnxpfs6
   Q==;
X-CSE-ConnectionGUID: I54f2HoETKazH34Gi4czYA==
X-CSE-MsgGUID: CDQv7QaHQVynxt8rnB2oWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="50619082"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="50619082"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 13:52:41 -0700
X-CSE-ConnectionGUID: Cj6n6M3rTVuOoqAhFPI/fg==
X-CSE-MsgGUID: kr7aRojyQUGQYs4Bqi4fWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="144952758"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 13:52:41 -0700
Date: Fri, 30 May 2025 13:52:39 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Zaid Alali <zaidal@os.amperecomputing.com>, rafael@kernel.org,
	lenb@kernel.org, james.morse@arm.com, robert.moore@intel.com,
	Jonathan.Cameron@huawei.com, ira.weiny@intel.com,
	Benjamin.Cheatham@amd.com, dan.j.williams@intel.com, arnd@arndb.de,
	Avadhut.Naik@amd.com, john.allen@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v7 9/9] ACPI: APEI: EINJ: Update the documentation for
 EINJv2 support
Message-ID: <aDoal24J-BMTIBCq@agluck-desk3>
References: <20250506213814.2365788-1-zaidal@os.amperecomputing.com>
 <20250506213814.2365788-10-zaidal@os.amperecomputing.com>
 <20250530102711.GAaDmH_1O7lc6kuveY@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530102711.GAaDmH_1O7lc6kuveY@fat_crate.local>

On Fri, May 30, 2025 at 12:27:11PM +0200, Borislav Petkov wrote:
> On Tue, May 06, 2025 at 02:38:13PM -0700, Zaid Alali wrote:
> > +- einjv2_component_array
> > +
> > +  The contents of this file are used to set the "Component Array" field
> > +  of the EINJv2 Extension Structure. The expected format is hex values
> > +  for component id and syndrome separated by space, and multiple
> > +  components are separated by new line.
> 
> How is this a good design?
> 
> Do you guys not see that the other injection files are one value per file?
> 
> > +  # comp_arr="0x1 0x2				# Fill in the component array
> > +    >0x1 0x4
> > +    >0x2 0x4"
> > +  # echo "$comp_arr" > einjv2_component_array
> 
> Oh boy. Srsly?!

I've been staring at the debugfs blob used for einjv2_component_array
to try and come up with some sane way to use it ... but I think it is
a lost cause and I agree we need "one file, one value" like the rest of
the EINJ user interface.

I poked at the code a bit and mangled it into the patch below. I've
tested that the new files read/write as expected. But I don't have
an EINJV2 enabled system to run a full test.

New files in the einj directory (assuming the system reports that
it supports up to four simultaneous injections):

-rw-------. 1 root root 0 May 30 13:26 component_id0
-rw-------. 1 root root 0 May 30 13:26 component_id1
-rw-------. 1 root root 0 May 30 13:26 component_id2
-rw-------. 1 root root 0 May 30 13:26 component_id3
-rw-------. 1 root root 0 May 30 13:26 component_syndrome0
-rw-------. 1 root root 0 May 30 13:26 component_syndrome1
-rw-------. 1 root root 0 May 30 13:26 component_syndrome2
-rw-------. 1 root root 0 May 30 13:26 component_syndrome3
-r--------. 1 root root 0 May 30 13:26 max_nr_components
-rw-------. 1 root root 0 May 30 13:26 nr_components

Use case to inject to one device would be:

# echo 1 > nr_components
# echo 4 > component_id0
# echo A5A5A5A5 > component_syndrome0
... set other files and finish with usual
# echo 1 > error_inject

There isn't a fancy "debugfs_create_x128_le()" helper to manage these
128-bit little endian numbers. So I've coded with the basic building
blocks (though using copy_from_user() and copy_to_user() feels like
back in the stone age). If there some helpers that I missed I'd be
happy to see that part simplified.

Patch is on top of the existing v7 set. Obviously it needs to be folded
back into the earlier patches to make a clean history that doesn't add
functions and then replace them with different code.

-Tony

---

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index ab3d20b51ff1..9f29fc97f6a6 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -65,7 +65,7 @@ struct syndrome_array {
 		u8	pcie_synd[16];
 		u8	vendor_synd[16];
 	} comp_synd;
-};
+} *syndrome_data;
 
 struct einjv2_extension_struct {
 	u32 length;
@@ -117,9 +117,7 @@ static struct debugfs_blob_wrapper vendor_blob;
 static struct debugfs_blob_wrapper vendor_errors;
 static char vendor_dev[64];
 
-static struct debugfs_blob_wrapper einjv2_component_arr;
-static void *user_input;
-static int nr_components;
+static u32 max_nr_components, nr_components;
 static u32 available_error_type;
 static u32 available_error_type_v2;
 
@@ -327,7 +325,7 @@ static void __iomem *einj_get_parameter_address(void)
 			if (available_error_type & ACPI65_EINJV2_SUPP) {
 				len = v5param.einjv2_struct.length;
 				offset = offsetof(struct einjv2_extension_struct, component_arr);
-				nr_components = (len - offset) /
+				max_nr_components = (len - offset) /
 						sizeof(v5param.einjv2_struct.component_arr[0]);
 				/*
 				 * The first call to acpi_os_map_iomem above does not include the
@@ -338,7 +336,7 @@ static void __iomem *einj_get_parameter_address(void)
 				acpi_os_unmap_iomem(p, v5param_size);
 				offset = offsetof(struct set_error_type_with_address, einjv2_struct);
 				v5param_size = offset + struct_size(&v5param.einjv2_struct,
-					component_arr, nr_components);
+					component_arr, max_nr_components);
 				p = acpi_os_map_iomem(pa_v5, v5param_size);
 			}
 			return p;
@@ -518,104 +516,6 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 	return rc;
 }
 
-static int parse_hex_to_u8(char *str, u8 *arr)
-{
-	char *ptr, val[32];
-	int pad, str_len;
-
-
-	if (str[0] == '0' && (str[1] == 'x' || str[1] == 'X'))
-		str += 2;
-
-	str_len = strlen(str);
-	if (str_len > 32)
-		return -EINVAL;
-
-	memcpy(val, str, str_len);
-
-	ptr = val;
-	while (*ptr != '\0') {
-		if (!isxdigit(*ptr))
-			return -EINVAL;
-		ptr++;
-	}
-
-	pad = 32 - str_len;
-
-	memmove(val + pad, val, str_len);
-	memset(val, '0', pad);
-
-	for (int i = 0; i < COMPONENT_LEN; ++i) {
-		char byte_str[3] = {val[i * 2], val[i * 2 + 1], '\0'};
-		/* write bytes in little endian format to follow ACPI specs */
-		arr[COMPONENT_LEN - i - 1] = (u8)strtoul(byte_str, NULL, 16);
-	}
-
-	return 0;
-}
-
-static int read_component_array(struct set_error_type_with_address *v5param)
-{
-	int count = 0, str_len;
-	u8 comp_arr[COMPONENT_LEN], synd_arr[COMPONENT_LEN];
-	struct syndrome_array *component_arr;
-	char *tok, *comp_str, *synd_str, *user;
-
-	component_arr = v5param->einjv2_struct.component_arr;
-	str_len = strlen(user_input);
-	user = user_input;
-	user[str_len - 1] = '\0';
-	while ((tok = strsep(&user, "\n")) != NULL) {
-		if (count >= nr_components)
-			return -EINVAL;
-
-		comp_str = strsep(&tok, " \t");
-		synd_str = strsep(&tok, " \t");
-
-		if (!comp_str || !synd_str)
-			return -EINVAL;
-
-		if (parse_hex_to_u8(comp_str, comp_arr))
-			return -EINVAL;
-		if (parse_hex_to_u8(synd_str, synd_arr))
-			return -EINVAL;
-
-		switch (v5param->type) {
-		case EINJV2_PROCESSOR_ERROR:
-			for (int i = 0; i < COMPONENT_LEN; ++i) {
-				component_arr[count].comp_id.acpi_id[i] = comp_arr[i];
-				component_arr[count].comp_synd.proc_synd[i] = synd_arr[i];
-			}
-			break;
-		case EINJV2_MEMORY_ERROR:
-			for (int i = 0; i < COMPONENT_LEN; ++i) {
-				component_arr[count].comp_id.device_id[i] = comp_arr[i];
-				component_arr[count].comp_synd.mem_synd[i] = synd_arr[i];
-			}
-			break;
-		case EINJV2_PCIE_ERROR:
-			for (int i = 0; i < COMPONENT_LEN; ++i) {
-				component_arr[count].comp_id.pcie_sbdf[i] = comp_arr[i];
-				component_arr[count].comp_synd.pcie_synd[i] = synd_arr[i];
-			}
-			break;
-		case EINJV2_VENDOR_ERROR:
-			for (int i = 0; i < COMPONENT_LEN; ++i) {
-				component_arr[count].comp_id.vendor_id[i] = comp_arr[i];
-				component_arr[count].comp_synd.vendor_synd[i] = synd_arr[i];
-			}
-			break;
-		}
-		count++;
-
-	}
-	v5param->einjv2_struct.component_arr_count = count;
-
-	/* clear buffer after user input for next injection */
-	memset(user_input, 0, COMP_ARR_SIZE);
-	return 0;
-}
-
 static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 			       u64 param3, u64 param4)
 {
@@ -655,13 +555,17 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 			v5param->memory_address_range = param2;
 
 			if (is_V2) {
-				rc = read_component_array(v5param);
-				if (rc) {
+				if (nr_components < 1 || nr_components > max_nr_components) {
 					kfree(v5param);
-					goto err_out;
+					return -EINVAL;
+				}
+				v5param->einjv2_struct.component_arr_count = nr_components;
+				for (int i = 0; i < nr_components; i++) {
+					v5param->einjv2_struct.component_arr[i].comp_id =
+						syndrome_data[i].comp_id;
+					v5param->einjv2_struct.component_arr[i].comp_synd =
+						syndrome_data[i].comp_synd;
 				}
-				/* clear buffer after user input for next injection */
-				memset(user_input, 0, COMP_ARR_SIZE);
 			} else {
 				v5param->apicid = param3;
 				v5param->pcie_sbdf = param4;
@@ -742,9 +646,6 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	rc = apei_exec_run_optional(&ctx, ACPI_EINJ_END_OPERATION);
 
 	return rc;
-err_out:
-	memset(user_input, 0, COMP_ARR_SIZE);
-	return -EINVAL;
 }
 
 /* Inject the specified hardware error */
@@ -984,6 +885,97 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
 	return 0;
 }
 
+static ssize_t u128_read(struct file *f, char __user *buf, size_t count, loff_t *off)
+{
+	char output[2 * COMPONENT_LEN + 1];
+	u8 *data = f->f_inode->i_private;
+	ssize_t n;
+	int i;
+
+	if (*off >= sizeof(output))
+		return 0;
+
+	for (i = 0; i < COMPONENT_LEN; i++)
+		sprintf(output + 2 * i, "%.02x", data[i]);
+	output[2 * COMPONENT_LEN] = '\n';
+
+	n = min(count, sizeof(output) - *off);
+	if (copy_to_user(buf, output + *off, n))
+		return -EFAULT;
+	*off += n;
+
+	return n;
+}
+
+static ssize_t u128_write(struct file *f, const char __user *buf, size_t count, loff_t *off)
+{
+	char input[2 + 2 * COMPONENT_LEN + 2];
+	u8 *save = f->f_inode->i_private;
+	u8 tmp[COMPONENT_LEN];
+	char byte[3] = {};
+	char *s, *e;
+	long val;
+	int i;
+
+	if (count > sizeof(input))
+		return -EINVAL;
+	if (copy_from_user(input, buf, count))
+		return -EFAULT;
+
+	if (input[0] == '0' && (input[1] == 'x' || input[1] == 'X'))
+		s = input + 2;
+	else
+		s = input;
+	e = input + count;
+	if (e[-1] == '\n')
+		e--;
+
+	for (i = 0; i < COMPONENT_LEN; i++) {
+		byte[1] = *--e;
+		byte[0] = e > s ? *--e : '0';
+		if (kstrtol(byte, 16, &val))
+			return -EINVAL;
+		tmp[i] = val;
+		if (e <= s)
+			break;
+	}
+	while (++i < COMPONENT_LEN)
+		tmp[i] = 0;
+
+	memcpy(save, tmp, COMPONENT_LEN);
+
+	return count;
+}
+
+static const struct file_operations u128_fops = {
+	.read	= u128_read,
+	.write	= u128_write,
+};
+
+static bool setup_einjv2_component_files(void)
+{
+	char name[32];
+
+	max_nr_components = 4; //FAKE!!!
+	debugfs_create_u32("max_nr_components", 0400, einj_debug_dir, &max_nr_components);
+	debugfs_create_u32("nr_components", 0600, einj_debug_dir, &nr_components);
+
+	syndrome_data = kcalloc(max_nr_components, sizeof(syndrome_data[0]), GFP_KERNEL);
+	if (!syndrome_data)
+		return false;
+
+	for (int i = 0; i < max_nr_components; i++) {
+		sprintf(name, "component_id%d", i);
+		debugfs_create_file(name, 0600, einj_debug_dir,
+				    &syndrome_data[i].comp_id, &u128_fops);
+		sprintf(name, "component_syndrome%d", i);
+		debugfs_create_file(name, 0600, einj_debug_dir,
+				    &syndrome_data[i].comp_synd, &u128_fops);
+	}
+
+	return true;
+}
+
 static int __init einj_probe(struct faux_device *fdev)
 {
 	int rc;
@@ -1056,21 +1048,10 @@ static int __init einj_probe(struct faux_device *fdev)
 		debugfs_create_x32("notrigger", S_IRUSR | S_IWUSR,
 				   einj_debug_dir, &notrigger);
 		if (available_error_type & ACPI65_EINJV2_SUPP) {
-			user_input = kzalloc(COMP_ARR_SIZE, GFP_KERNEL);
-			if (!user_input) {
-				EINJv2_enabled = false;
-				pr_info("EINJv2 is disabled: not enough memory\n");
-				goto skip_EINJv2;
-			}
-			EINJv2_enabled = true;
-			einjv2_component_arr.data = user_input;
-			einjv2_component_arr.size = COMP_ARR_SIZE;
-			debugfs_create_blob("einjv2_component_array", S_IRUSR | S_IWUSR,
-					einj_debug_dir, &einjv2_component_arr);
+			EINJv2_enabled = setup_einjv2_component_files();
 		}
 	}
 
-skip_EINJv2:
 	if (vendor_dev[0]) {
 		vendor_blob.data = vendor_dev;
 		vendor_blob.size = strlen(vendor_dev);
@@ -1112,7 +1093,7 @@ static void __exit einj_remove(struct faux_device *fdev)
 		if (vendor_errors.size)
 			acpi_os_unmap_memory(vendor_errors.data, vendor_errors.size);
 	}
-	kfree(user_input);
+	kfree(syndrome_data);
 	einj_exec_ctx_init(&ctx);
 	apei_exec_post_unmap_gars(&ctx);
 	apei_resources_release(&einj_resources);
-- 
2.49.0


